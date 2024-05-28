import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Model/BusinessScope/businessScopeModel.dart';
import 'package:part_time_app/Model/User/userModel.dart';
import 'package:part_time_app/Services/BusinessScope/businessScopeServices.dart';
import 'package:part_time_app/Services/User/userServices.dart';
import 'package:part_time_app/Utils/sharedPreferencesUtils.dart';
import 'dart:io';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

late TextEditingController usernameController;
late TextEditingController countryController;
late TextEditingController sexController;
late TextEditingController emailController;
late TextEditingController nameController;
late TextEditingController walletNetworkController;
late TextEditingController walletAddressController;
late TextEditingController usdtLinkController;
late TextEditingController firstPhoneNoController;
late TextEditingController secondPhoneNoController;

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
  String dialCode = '';
  String phone = '';
  String countryCode = '';
  String? dropdownGenderValue;
  String? dropdownbusinessScopeValue;
  String? avatarUrl;
  bool isLoading = false;
  List<BusinessScopeData> businessScopeList = [];
  UpdateCustomerInfoModel? updateCustomerInfoModel;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    getBusinessScopeList();
    initializeControllers();
    getUserInfo();
  }

  void initializeControllers() {
    usernameController = TextEditingController();
    countryController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    walletNetworkController = TextEditingController();
    walletAddressController = TextEditingController();
    usdtLinkController = TextEditingController();
    firstPhoneNoController = TextEditingController();
    secondPhoneNoController = TextEditingController();
  }

  Future<void> getBusinessScopeList() async {
    List<BusinessScopeData>? fetchedBusinessScopeList =
        await businessScopeServices.getBusinessScopeList();
    if (fetchedBusinessScopeList != null) {
      setState(() {
        businessScopeList = fetchedBusinessScopeList;
      });
    }
  }

  Future<void> getUserInfo() async {
    UserData? data = await SharedPreferencesUtils.getUserDataInfo();
    setState(() {
      usernameController.text = data?.username ?? '';
      countryController.text = data?.country ?? '';
      emailController.text = data?.email ?? '';
      nameController.text = data?.nickname ?? '';
      walletNetworkController.text = data?.bilingNetwork ?? '';
      walletAddressController.text = data?.bilingAddress ?? '';
      usdtLinkController.text = data?.bilingCurrency ?? '';
      dropdownGenderValue = data?.gender ?? '';
      firstPhoneNoController.text =
          _stripCountryCode(data?.firstPhoneNo, "+60");
      secondPhoneNoController.text = data?.secondPhoneNo ?? '';
      avatarUrl = data?.avatar ?? '';
      dropdownbusinessScopeValue = data?.businessScopeName ?? '';
    });
  }

  String _stripCountryCode(String? phoneNumber, String countryCode) {
    if (phoneNumber != null && phoneNumber.startsWith(countryCode)) {
      return phoneNumber.substring(countryCode.length);
    }
    return phoneNumber ?? '';
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String firstPhoneNumber = firstPhoneNoController.text.trim();
      String secondPhoneNumber = secondPhoneNoController.text.trim();

      UserData updatedUserData = UserData(
        nickname: nameController.text,
        username: usernameController.text,
        country: countryController.text,
        gender: dropdownGenderValue,
        avatar: avatarUrl,
        firstPhoneNo: firstPhoneNoController.text,
        secondPhoneNo: secondPhoneNoController.text,
        email: emailController.text,
        businessScopeName: dropdownbusinessScopeValue,
        bilingNetwork: walletNetworkController.text,
        bilingAddress: walletAddressController.text,
        bilingCurrency: usdtLinkController.text,
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

      // Refresh the user info after updating
      getUserInfo();
    }
  }

void openImagePicker() async {
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    File imageFile = File(image.path);
    print("Selected image: $imageFile");

    setState(() {
      isLoading = true; // Start loading indicator
    });

    try {
      UploadCustomerAvatarModel? result = await services.uploadAvatar(imageFile);

      if (result != null && result.code == 200 && result.data != null) {
        setState(() {
          avatarUrl = result.data!; // Update with the returned filename
          isLoading = false; // Stop loading indicator
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Avatar updated successfully!')),
        );
      } else {
        setState(() {
          isLoading = false; // Stop loading indicator
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update avatar.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading indicator
      });
      print("Error updating profile picture: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating avatar.')),
      );
    }
  } else {
    // User cancelled the selection
  }
}


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
                    avatarUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: Image.network(
                              avatarUrl!,
                              height: 58,
                              width: 58,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Stack(
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
                                  width: 24,
                                ),
                              ),
                            ],
                          )
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
                              controller: nameController,
                              onChanged: (value) {
                                if (widget.onNameChange != null) {
                                  widget.onNameChange!(value);
                                }
                              },
                              readOnly: false)
                        ] else ...[
                          Text("真实姓名", style: depositTextStyle2),
                          _buildTextInput(
                              hintText: "真实姓名",
                              controller: usernameController,
                              onChanged: (value) {
                                if (widget.onUsernameChange != null) {
                                  widget.onUsernameChange!(value);
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
                                    controller: countryController,
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
                                    value: dropdownbusinessScopeValue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: missionUsernameTextStyle,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownbusinessScopeValue = newValue!;
                                        // Handle business scope value change here if needed
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
                              controller: emailController,
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
                              controller: usernameController,
                              onChanged: (value) {
                                if (widget.onUsernameChange != null) {
                                  widget.onUsernameChange!(value);
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
                                        "+60",
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
                                        controller: firstPhoneNoController,
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
                                  textFieldController: secondPhoneNoController,
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
                                  },
                                  // autoValidateMode:
                                  //     AutovalidateMode.onUserInteraction,
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
                              controller: walletAddressController,
                              onChanged: (value) {
                                if (widget.onWalletAddressChange != null) {
                                  widget.onWalletAddressChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 5),
                          _buildTextInput(
                              hintText: "NETWORK 名称",
                              controller: walletNetworkController,
                              onChanged: (value) {
                                if (widget.onWalletNetworkChange != null) {
                                  widget.onWalletNetworkChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 5),
                          _buildTextInput(
                              hintText: "货币- USDT",
                              controller: usdtLinkController,
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
                              controller: walletAddressController,
                              onChanged: (value) {
                                if (widget.onWalletNetworkChange != null) {
                                  widget.onWalletNetworkChange!(value);
                                }
                              },
                              readOnly: false),
                          SizedBox(height: 10),
                          _buildTextInput(
                              hintText: "USDT 链地址",
                              controller: usdtLinkController,
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
