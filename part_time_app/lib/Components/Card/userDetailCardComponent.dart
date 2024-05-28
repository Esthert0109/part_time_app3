import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Model/BusinessScope/businessScopeModel.dart';
import 'package:part_time_app/Model/User/userModel.dart';
import 'package:part_time_app/Services/BusinessScope/businessScopeServices.dart';
import 'package:part_time_app/Services/Upload/uploadServices.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'dart:io';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Utils/sharedPreferencesUtils.dart';

late TextEditingController usernameControllerPayment;
late TextEditingController countryControllerPayment;
late TextEditingController fieldControllerPayment;
late TextEditingController sexControllerPayment;
late TextEditingController emailControllerPayment;
late TextEditingController nameControllerPayment;
late TextEditingController walletNetworkControllerPayment;
late TextEditingController walletAddressControllerPayment;
late TextEditingController firstPhoneNoControllerPayment;
late TextEditingController secondPhoneNoControllerPayment;
TextEditingController usdtLinkControllerPayment = TextEditingController();

class UserDetailCardComponent extends StatefulWidget {
  bool isEditProfile;
  final Function(String)? onUsernameChange;
  final Function(String)? onCountryChange;
  final Function(String)? onEmailChange;
  final Function(String)? onNameChange;
  final Function(String)? onWalletNetworkChange;
  final Function(String)? onWalletAddressChange;
  final Function(String)? onUsdtLinkChange;
  final Function(String)? onfirstPhoneNoChange;
  final Function(String)? onsecondPhoneNoChange;
  final String? usernameInitial;
  final String? countryInitial;
  final String? fieldInitial;
  final String? sexInitial;
  final String? emailInitial;
  final String? nameInitial;
  final String? countryCode;
  final String? phoneNumber;
  final String? walletNetworkInitial;
  final String? walletAddressInitial;
  final String? usdtLinkInitial;
  final String? genderInitial;
  final String? firstPhoneNoInitial;
  final String? secondPhoneNoInitial;

  UserDetailCardComponent({
    super.key,
    required this.isEditProfile,
    this.onUsernameChange,
    this.onCountryChange,
    this.onEmailChange,
    this.onNameChange,
    this.onWalletNetworkChange,
    this.onWalletAddressChange,
    this.onUsdtLinkChange,
    this.onfirstPhoneNoChange,
    this.onsecondPhoneNoChange,
    this.usernameInitial,
    this.countryInitial,
    this.fieldInitial,
    this.sexInitial,
    this.emailInitial,
    this.nameInitial,
    this.countryCode,
    this.phoneNumber,
    this.walletNetworkInitial,
    this.walletAddressInitial,
    this.usdtLinkInitial,
    this.genderInitial,
    this.firstPhoneNoInitial,
    this.secondPhoneNoInitial,
  });

  @override
  State<UserDetailCardComponent> createState() =>
      _UserDetailCardComponentState();
}

class _UserDetailCardComponentState extends State<UserDetailCardComponent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneControllerLogin = TextEditingController();
  UserServices services = UserServices();
  final BusinessScopeServices businessScopeServices = BusinessScopeServices();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
  File? imageFile;
  String uploadedAvatar = "";
  String dialCode = '';
  String phone = '';
  String countryCode = '';
  String? firstContact;
  String? code;
  String? secondContact;
  String? secondCode;
  String? username;
  String? dropdownGenderValue;
  String? dropdownbusinessScopeValue;
  String? avatarUrl;
  String? dropdownBusinessScopeValue;
  int? selectedBusinessScopeId;
  bool isLoading = false;
  List<BusinessScopeData> businessScopeList = [];
  UpdateCustomerInfoModel? updateCustomerInfoModel;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    getBusinessScopeList();
    initializeControllers();
    _loadDataFromShared();
  }

  void initializeControllers() {
    usernameControllerPayment = TextEditingController();
    countryControllerPayment = TextEditingController();
    emailControllerPayment = TextEditingController();
    nameControllerPayment = TextEditingController();
    walletNetworkControllerPayment = TextEditingController();
    walletAddressControllerPayment = TextEditingController();
    usdtLinkControllerPayment = TextEditingController();
    firstPhoneNoControllerPayment = TextEditingController();
    secondPhoneNoControllerPayment = TextEditingController();
  }

  Future<void> _loadDataFromShared() async {
    String? phoneNo = await SharedPreferencesUtils.getPhoneNo();
    UserData? user = await SharedPreferencesUtils.getUserDataInfo();
    if (phoneNo != null) {
      Map<String, String> separated = separatePhoneNumber(phoneNo);
      setState(() {
        code = separated["countryCode"];
        firstContact = separated["phoneNumber"];
        username = user?.username;
        usernameControllerPayment.text = username ?? '';
        countryControllerPayment.text = user?.country ?? '';
        emailControllerPayment.text = user?.email ?? '';
        nameControllerPayment.text = user?.nickname ?? '';
        walletNetworkControllerPayment.text = user?.billingNetwork ?? '';
        walletAddressControllerPayment.text = user?.billingAddress ?? '';
        usdtLinkControllerPayment.text = user?.billingCurrency ?? '';
        dropdownGenderValue = user?.gender ?? '';
        firstPhoneNoControllerPayment.text = firstContact ?? '';
        Map<String, String> separatedSecond =
            separatePhoneNumber(user?.secondPhoneNo ?? '');
        secondCode = separatedSecond["countryCode"];
        secondContact = separatedSecond["phoneNumber"];
        secondPhoneNoControllerPayment.text = secondContact ?? '';
        avatarUrl = user?.avatar ?? '';
        selectedBusinessScopeId = user?.businessScopeId;
      });
      if (selectedBusinessScopeId != null) {
        BusinessScopeData? businessScope = await businessScopeServices
            .getBusinessScopeById(selectedBusinessScopeId!);
        setState(() {
          dropdownBusinessScopeValue = businessScope?.businessScopeName;
        });
      }
    }
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String firstPhoneNumber = firstPhoneNoControllerPayment.text.trim();
      String secondPhoneNumber = secondPhoneNoControllerPayment.text.trim();

      UserData updatedUserData = UserData(
        nickname: nameControllerPayment.text,
        username: usernameControllerPayment.text,
        country: countryControllerPayment.text,
        gender: dropdownGenderValue,
        avatar: uploadedAvatar.isNotEmpty ? uploadedAvatar : avatarUrl ?? '',
        firstPhoneNo: firstPhoneNoControllerPayment.text,
        secondPhoneNo: phone,
        email: emailControllerPayment.text,
        businessScopeId: selectedBusinessScopeId,
        billingNetwork: walletNetworkControllerPayment.text,
        billingAddress: walletAddressControllerPayment.text,
        billingCurrency: usdtLinkControllerPayment.text,
      );

      if (firstPhoneNumber == secondPhoneNumber) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'The first and second phone numbers cannot be the same.')),
        );
        return;
      }

      await SharedPreferencesUtils.saveUserDataInfo(updatedUserData);

      UpdateCustomerInfoModel? result =
          await services.updateCustomerInfo(updatedUserData);

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User information updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user information.')),
        );
      }
      _loadDataFromShared();
    }
  }

  Future<void> getBusinessScopeList() async {
    List<BusinessScopeData>? fetchedBusinessScopeList =
        await businessScopeServices.getBusinessScopeList();
    if (fetchedBusinessScopeList != null) {
      setState(() {
        businessScopeList = fetchedBusinessScopeList;
        if (dropdownBusinessScopeValue == null &&
            fetchedBusinessScopeList.isNotEmpty) {
          dropdownBusinessScopeValue =
              fetchedBusinessScopeList.first.businessScopeName;
          selectedBusinessScopeId =
              fetchedBusinessScopeList.first.businessScopeId;
        }
      });
    }
  }

  Map<String, String> separatePhoneNumber(String phoneNumber) {
    String countryCode = phoneNumber.substring(0, 3); // Extracts "+60"
    String remainingNumber =
        phoneNumber.substring(3); // Extracts the rest of the number

    return {
      "countryCode": countryCode,
      "phoneNumber": remainingNumber,
    };
  }

  void openImagePicker() async {
    XFile? profilePic = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (profilePic != null) {
        imageFile = File(profilePic.path);
        isLoading = true;
      } else {}
    });
    try {
      if (imageFile != null) {
        String? uploaded = await UploadServices().uploadAvatar(imageFile!);
        print("Checking imageFile $imageFile");

        if (uploaded != null) {
          Fluttertoast.showToast(
              msg: "已上传",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kMainGreyColor,
              textColor: kThirdGreyColor);

          setState(() {
            isLoading = false;
            uploadedAvatar = uploaded;
          });
        } else {
          Fluttertoast.showToast(
              msg: "上传失败",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kMainGreyColor,
              textColor: kThirdGreyColor);

          setState(() {
            isLoading = false;
          });
        }
      } else {}
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kMainGreyColor,
          textColor: kThirdGreyColor);

      setState(() {
        isLoading = false;
      });
    }
  }

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print("edit image");
                openImagePicker();
              },
              child: Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (imageFile != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: Image.file(
                          imageFile!,
                          height: 58,
                          width: 58,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (avatarUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: Image.network(
                          avatarUrl!,
                          height: 58,
                          width: 58,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/profile/profile_img.svg",
                            height: 58,
                            width: 58,
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: SvgPicture.asset(
                              "assets/profile/camera.svg",
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: kMainWhiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isEditProfile) ...[
                          Text("用户名", style: depositTextStyle2),
                          _buildTextInput(
                              hintText: "请输入用户名",
                              controller: usernameControllerPayment,
                              onChanged: (value) {
                                if (widget.onUsernameChange != null) {
                                  widget.onUsernameChange!(value);
                                }
                              },
                              readOnly: false)
                        ] else ...[
                          Text("真实姓名", style: depositTextStyle2),
                          _buildTextInput(
                              hintText: "真实姓名",
                              controller: nameControllerPayment,
                              onChanged: (value) {
                                if (widget.onNameChange != null) {
                                  widget.onNameChange!(value);
                                }
                              },
                              readOnly: false),
                        ],
                        SizedBox(height: 15),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Text("所在地 (国家)",
                                      style: depositTextStyle2)),
                              SizedBox(width: 10),
                              Expanded(
                                  flex: 3,
                                  child:
                                      Text("经营范围", style: depositTextStyle2)),
                              SizedBox(width: 10),
                              Expanded(
                                  flex: 2,
                                  child: Text("性别", style: depositTextStyle2))
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: _buildTextInput(
                                    hintText: "请输入国家",
                                    controller: countryControllerPayment,
                                    onChanged: (value) {
                                      if (widget.onCountryChange != null) {
                                        widget.onCountryChange!(value);
                                      }
                                    },
                                    readOnly: false),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 31,
                                  decoration: BoxDecoration(
                                    color: kInputBackGreyColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    value: dropdownBusinessScopeValue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: missionUsernameTextStyle,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownBusinessScopeValue = newValue!;
                                        selectedBusinessScopeId =
                                            businessScopeList
                                                .firstWhere((element) =>
                                                    element.businessScopeName ==
                                                    newValue)
                                                .businessScopeId;
                                      });
                                    },
                                    items: businessScopeList
                                        .map<DropdownMenuItem<String>>(
                                            (BusinessScopeData value) {
                                      return DropdownMenuItem<String>(
                                        value: value.businessScopeName,
                                        child: Text(value.businessScopeName),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 31,
                                  decoration: BoxDecoration(
                                      color: kInputBackGreyColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    value: dropdownGenderValue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: missionUsernameTextStyle,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownGenderValue = newValue!;
                                        // Handle sex value change here if needed
                                      });
                                    },
                                    items: <String>['男', '女']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        if (widget.isEditProfile) ...[
                          Text("邮箱", style: depositTextStyle2),
                          _buildTextInput(
                              hintText: "邮箱",
                              controller: emailControllerPayment,
                              onChanged: (value) {
                                if (widget.onEmailChange != null) {
                                  widget.onEmailChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 15),
                          Text("真实姓名", style: depositTextStyle2),
                          _buildTextInput(
                              hintText: "真实姓名",
                              controller: nameControllerPayment,
                              onChanged: (value) {
                                if (widget.onNameChange != null) {
                                  widget.onNameChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 15),
                        ],
                        Text("第一联系方式", style: depositTextStyle2),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      height: 31,
                                      decoration: BoxDecoration(
                                          color: kInputBackGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        code ?? "",
                                        style: missionUsernameTextStyle,
                                        textAlign: TextAlign.center,
                                      ))),
                              SizedBox(width: 10),
                              Expanded(
                                  flex: 12,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5, left: 12),
                                    height: 31,
                                    decoration: BoxDecoration(
                                        color: kInputBackGreyColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: _buildTextInput(
                                        hintText: "",
                                        controller:
                                            firstPhoneNoControllerPayment,
                                        onChanged: (value) {
                                          if (widget.onfirstPhoneNoChange !=
                                              null) {
                                            widget.onfirstPhoneNoChange!(value);
                                          }
                                        },
                                        readOnly: true),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text("第二联系方式", style: depositTextStyle2),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                              child: Stack(children: [
                            Positioned(
                              child: Container(
                                height: 31,
                                child: InternationalPhoneNumberInput(
                                  errorMessage: "手机号码不正确",
                                  initialValue: phoneNumber,
                                  textFieldController:
                                      secondPhoneNoControllerPayment,
                                  formatInput: true,
                                  selectorConfig: const SelectorConfig(
                                      trailingSpace: true,
                                      leadingPadding: 10,
                                      setSelectorButtonAsPrefixIcon: true,
                                      showFlags: false,
                                      selectorType:
                                          PhoneInputSelectorType.DIALOG),
                                  onInputChanged: (PhoneNumber number) {
                                    phone = number.phoneNumber.toString();
                                    dialCode = number.dialCode.toString();
                                    countryCode = number.isoCode.toString();
                                    setState(() {
                                      secondCode = dialCode;
                                      secondContact = number.phoneNumber;
                                    });
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: Colors.black,
                                  inputDecoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      filled: true,
                                      fillColor: kInputBackGreyColor,
                                      contentPadding: EdgeInsets.only(
                                          right: 100, left: 100),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: "请输入电话号码",
                                      hintStyle: missionDetailText2),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(68, 0, 12, 0),
                                width: 3,
                                height: 31,
                                decoration: BoxDecoration(
                                  color: kMainWhiteColor,
                                ),
                                child: Text('     '),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(45, 0, 12, 0),
                                width: 3,
                                height: 31,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: kSecondGreyColor,
                                ),
                              ),
                            ),
                          ])),
                        ),
                        if (widget.isEditProfile) ...[
                          SizedBox(height: 15),
                          Text("收款信息", style: depositTextStyle2),
                          _buildTextInput(
                              hintText: "钱包地址 (account number)",
                              controller: walletAddressControllerPayment,
                              onChanged: (value) {
                                if (widget.onWalletAddressChange != null) {
                                  widget.onWalletAddressChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 5),
                          _buildTextInput(
                              hintText: "NETWORK 名称",
                              controller: walletNetworkControllerPayment,
                              onChanged: (value) {
                                if (widget.onWalletNetworkChange != null) {
                                  widget.onWalletNetworkChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 5),
                          _buildTextInput(
                              hintText: "货币- USDT",
                              controller: usdtLinkControllerPayment,
                              onChanged: (value) {
                                if (widget.onUsernameChange != null) {
                                  widget.onUsernameChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 15),
                          GestureDetector(
                              onTap: () {
                                // showModalBottomSheet(
                                //   context: context,
                                //   isScrollControlled: true,
                                //   useSafeArea: true,
                                //   builder: (BuildContext context) {
                                //     return ClipRRect(
                                //         borderRadius:
                                //             BorderRadius.circular(30.0),
                                //         child: SizedBox(
                                //           height: MediaQuery.of(context)
                                //                   .size
                                //                   .height *
                                //               0.9,
                                //           child: const ChangePasswordPage(
                                //             phone: '+601110916968',
                                //           ),
                                //         ));
                                //   },
                                // );
                              },
                              child: Text(
                                "修改密码",
                                style: editProfilePassTextStyle,
                              ))
                        ] else ...[
                          SizedBox(height: 15),
                          Text("收款信息", style: depositTextStyle2),
                          SizedBox(height: 5),
                          _buildTextInput(
                              hintText: "USDT 链名称",
                              controller: walletAddressControllerPayment,
                              onChanged: (value) {
                                if (widget.onWalletNetworkChange != null) {
                                  widget.onWalletNetworkChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 10),
                          _buildTextInput(
                              hintText: "USDT 链地址",
                              controller: walletAddressControllerPayment,
                              onChanged: (value) {
                                if (widget.onUsdtLinkChange != null) {
                                  widget.onUsdtLinkChange!(value);
                                }
                              },
                              readOnly: false),
                        ],
                      ],
                    ),
                  )),
            ),
          ],
        ))),
        Material(
          elevation: 20,
          child: Container(
              padding: const EdgeInsets.only(
                  bottom: 50, left: 10, right: 10, top: 5),
              decoration: const BoxDecoration(color: kMainWhiteColor),
              width: double.infinity,
              child: primaryButtonComponent(
                isLoading: isLoading,
                text: "立刻保存",
                onPressed: () {
                  _updateUser();
                },
                buttonColor: kMainYellowColor,
                textStyle: missionCheckoutTotalPriceTextStyle,
              )),
        )
      ],
    );
  }

  Widget _buildTextInput({
    required String hintText,
    required TextEditingController controller,
    required Function(String) onChanged,
    required bool readOnly,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 31,
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: kInputBackGreyColor,
          hintText: hintText,
          hintStyle: missionDetailText2,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          labelStyle: depositTextStyle2,
        ),
      ),
    );
  }
}
