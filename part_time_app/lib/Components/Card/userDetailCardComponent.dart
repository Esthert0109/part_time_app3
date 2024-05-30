import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:part_time_app/Components/TextField/primaryTextFieldComponent.dart';
import 'package:part_time_app/Constants/globalConstant.dart';
import 'package:part_time_app/Services/User/userServices.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/BusinessScope/businessScopeModel.dart';
import '../../Model/User/userModel.dart';
import '../../Pages/UserAuth/otpCode.dart';
import '../../Services/BusinessScope/businessScopeServices.dart';
import '../../Utils/sharedPreferencesUtils.dart';

late TextEditingController usernameControllerPayment;
late TextEditingController countryControllerPayment;
late TextEditingController sexControllerPayment;
late TextEditingController emailControllerPayment;
late TextEditingController nameControllerPayment;
late TextEditingController walletNetworkControllerPayment;
late TextEditingController walletAddressControllerPayment;
TextEditingController usdtLinkControllerPayment = TextEditingController();
// String secondPhoneNumber = "";
PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
int bussinessIdSelected = 0;
String dialCode = '';
String phone = '';
String countryCode = '';

class UserDetailCardComponent extends StatefulWidget {
  bool isEditProfile;
  final Function(String)? onUsernameChange;
  final Function(String)? onCountryChange;
  final Function(String)? onFieldChange;
  final Function(String)? onEmailChange;
  final Function(String)? onNameChange;
  final Function(String)? onWalletNetworkChange;
  final Function(String)? onWalletAddressChange;
  final Function(String)? onUsdtLinkChange;
  final String? usernameInitial;
  final String? countryInitial;
  final int? fieldInitial;
  String? sexInitial;
  final String? emailInitial;
  final String? nameInitial;
  final String? countryCode;
  final String? phoneNumber;
  final String? walletNetworkInitial;
  final String? walletAddressInitial;
  final String? usdtLinkInitial;
  final String? profilePic;

  UserDetailCardComponent({
    super.key,
    required this.isEditProfile,
    this.onUsernameChange,
    this.onCountryChange,
    this.onFieldChange,
    this.onEmailChange,
    this.onNameChange,
    this.onWalletNetworkChange,
    this.onWalletAddressChange,
    this.onUsdtLinkChange,
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
    this.profilePic,
  });

  @override
  State<UserDetailCardComponent> createState() =>
      _UserDetailCardComponentState();
}

class _UserDetailCardComponentState extends State<UserDetailCardComponent> {
  TextEditingController phoneControllerLogin = TextEditingController();

  String? firstContact;
  String? code;
  String? username;
  String? gender;
  bool isError = true;

  // services
  BusinessScopeServices businessScopeServices = BusinessScopeServices();
  UserServices userServices = UserServices();
  List<BusinessScopeData> businessScope = [];

  BusinessScopeData? selectedBussinessScope;

  @override
  void initState() {
    super.initState();
    _loadDataFromShared();
    fetchBusinessScopeList();
    usernameControllerPayment =
        TextEditingController(text: widget.usernameInitial);
    countryControllerPayment =
        TextEditingController(text: widget.countryInitial);
    sexControllerPayment = TextEditingController(text: widget.sexInitial);
    emailControllerPayment = TextEditingController(text: widget.emailInitial);
    nameControllerPayment = TextEditingController(text: widget.nameInitial);
    walletNetworkControllerPayment =
        TextEditingController(text: widget.walletNetworkInitial);
    walletAddressControllerPayment =
        TextEditingController(text: widget.walletAddressInitial);
    usdtLinkControllerPayment =
        TextEditingController(text: widget.usdtLinkInitial);
    gender = widget.sexInitial;
    bussinessIdSelected = widget.fieldInitial!;

    getPhoneNumberWithRegion();
  }

  getPhoneNumberWithRegion() async {
    PhoneNumber phone =
        await PhoneNumber.getRegionInfoFromPhoneNumber(widget.phoneNumber!);
    setState(() {
      phoneNumber = phone;
    });
  }

  fetchBusinessScopeList() async {
    List<BusinessScopeData>? fetchedBusinessScopeList =
        await businessScopeServices.getBusinessScopeList();
    if (fetchedBusinessScopeList != null ||
        fetchedBusinessScopeList!.isNotEmpty) {
      setState(() {
        businessScope = fetchedBusinessScopeList;
        selectedBussinessScope = businessScope[bussinessIdSelected];
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
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
                    flex: 5, child: Text("所在地 (国家)", style: depositTextStyle2)),
                SizedBox(width: 10),
                Expanded(
                    flex: 4, child: Text("经营范围", style: depositTextStyle2)),
                SizedBox(width: 10),
                Expanded(flex: 2, child: Text("性别", style: depositTextStyle2))
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _buildTextInput(
                      hintText: "请输入国家",
                      controller: countryControllerPayment,
                      onChanged: (value) {
                        if (widget.onUsernameChange != null) {
                          widget.onUsernameChange!(value);
                        }
                      },
                      readOnly: false),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 31,
                    decoration: BoxDecoration(
                        color: kInputBackGreyColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButton<BusinessScopeData>(
                      underline: Container(),
                      value: selectedBussinessScope,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: missionUsernameTextStyle,
                      onChanged: (newValue) {
                        setState(() {
                          selectedBussinessScope = newValue!;
                          bussinessIdSelected =
                              selectedBussinessScope?.businessScopeId ?? 0;
                        });
                      },
                      items: businessScope
                          .map<DropdownMenuItem<BusinessScopeData>>((business) {
                        return DropdownMenuItem<BusinessScopeData>(
                          value: business,
                          child: Text(business.businessScopeName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(left: 10),
                    height: 31,
                    decoration: BoxDecoration(
                        color: kInputBackGreyColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButton<String>(
                      underline: Container(),
                      value: gender,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: missionUsernameTextStyle,
                      onChanged: (newValue) {
                        setState(() {
                          gender = newValue!;
                          sexControllerPayment.text = gender ?? "";
                          print(gender);
                          print(sexControllerPayment.text);
                        });
                      },
                      items: <String>['男', '女']
                          .map<DropdownMenuItem<String>>((String value) {
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
                  if (widget.onUsernameChange != null) {
                    widget.onUsernameChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 15),
            Text("真实姓名", style: depositTextStyle2),
            _buildTextInput(
                hintText: "真实姓名",
                controller: nameControllerPayment,
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
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          code ?? "",
                          style: missionDetailText2,
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
                        child: Text(
                          firstContact ?? "",
                          style: missionDetailText2,
                          textAlign: TextAlign.left,
                        ))),
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
              Container(
                height: isError ? 31 : 50,
                child: InternationalPhoneNumberInput(
                  onInputValidated: (value) {
                    setState(() {
                      isError = value;
                    });
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  errorMessage: "手机号码不正确",
                  initialValue: phoneNumber,
                  textFieldController: phoneControllerLogin,
                  formatInput: true,
                  selectorConfig: const SelectorConfig(
                      trailingSpace: true,
                      leadingPadding: 10,
                      setSelectorButtonAsPrefixIcon: true,
                      showFlags: false,
                      selectorType: PhoneInputSelectorType.DIALOG),
                  onInputChanged: (PhoneNumber number) {
                    phone = number.phoneNumber.toString();
                    dialCode = number.dialCode.toString();
                    countryCode = number.isoCode.toString();

                    if (isError) {
                      phoneNumber = PhoneNumber(
                          phoneNumber: phone,
                          dialCode: dialCode,
                          isoCode: countryCode);
                    }
                  },
                  cursorColor: Colors.black,
                  inputDecoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      filled: true,
                      fillColor: kInputBackGreyColor,
                      contentPadding:
                          EdgeInsets.only(right: 100, left: 100, top: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: "请输入电话号码",
                      hintStyle: missionDetailText2),
                ),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.fromLTRB(68, 0, 12, 0),
                  width: 3,
                  height: isError ? 31 : 50,
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
                  if (widget.onUsernameChange != null) {
                    widget.onUsernameChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 5),
            _buildTextInput(
                hintText: "NETWORK 名称",
                controller: walletNetworkControllerPayment,
                onChanged: (value) {
                  if (widget.onUsernameChange != null) {
                    widget.onUsernameChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 5),
            _buildTextInput(
                hintText: "货币- USDT",
                controller: TextEditingController(),
                onChanged: (value) {
                  if (widget.usdtLinkInitial != null) {
                    widget.usdtLinkInitial!;
                  }
                },
                readOnly: true),
            SizedBox(height: 15),
            GestureDetector(
                onTap: () async {
                  OTPUserModel? value =
                      await userServices.sendOTP(userData!.firstPhoneNo!, 2);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: OtpCodePage(
                            phone: userData!.firstPhoneNo!,
                            type: 2,
                            countdownTime: value!.data!.datetime,
                          ),
                        ),
                      );
                    },
                  );
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
                controller: walletNetworkControllerPayment,
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
                  if (widget.onWalletAddressChange != null) {
                    widget.onWalletAddressChange!(value);
                  }
                },
                readOnly: false),
          ],
        ],
      ),
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
        scrollPhysics: AlwaysScrollableScrollPhysics(),
        minLines: 1,
        maxLines: 1,
        expands: false,
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: kInputBackGreyColor,
          hintText: hintText,
          hintStyle: missionDetailText2,
          contentPadding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
