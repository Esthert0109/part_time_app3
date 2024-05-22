import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:part_time_app/Components/TextField/primaryTextFieldComponent.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/User/userModel.dart';
import '../../Utils/sharedPreferencesUtils.dart';

late TextEditingController usernameController;
late TextEditingController countryController;
late TextEditingController fieldController;
late TextEditingController sexController;
late TextEditingController emailController;
late TextEditingController nameController;
late TextEditingController walletNetworkController;
late TextEditingController walletAddressController;
late TextEditingController usdtLinkController;

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
  final String? fieldInitial;
  final String? sexInitial;
  final String? emailInitial;
  final String? nameInitial;
  final String? countryCode;
  final String? phoneNumber;
  final String? walletNetworkInitial;
  final String? walletAddressInitial;
  final String? usdtLinkInitial;

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
  });

  @override
  State<UserDetailCardComponent> createState() =>
      _UserDetailCardComponentState();
}

class _UserDetailCardComponentState extends State<UserDetailCardComponent> {
  TextEditingController phoneControllerLogin = TextEditingController();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'MY');
  String dialCode = '';
  String phone = '';
  String countryCode = '';
  String? firstContact;
  String? code;
  String? username;
  @override
  void initState() {
    super.initState();
    _loadDataFromShared();
    usernameController = TextEditingController(text: widget.usernameInitial);
    countryController = TextEditingController(text: widget.countryInitial);
    fieldController = TextEditingController(text: widget.fieldInitial);
    sexController = TextEditingController(text: widget.sexInitial);
    emailController = TextEditingController(text: widget.emailInitial);
    nameController = TextEditingController(text: widget.nameInitial);
    walletNetworkController =
        TextEditingController(text: widget.walletNetworkInitial);
    walletAddressController =
        TextEditingController(text: widget.walletAddressInitial);
    usdtLinkController = TextEditingController(text: widget.usdtLinkInitial);
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

  String? dropdownValue;
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
                controller: usernameController,
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
                controller: nameController,
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
                      controller: countryController,
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
                  child: _buildTextInput(
                      hintText: "请输入范围",
                      controller: fieldController,
                      onChanged: (value) {
                        if (widget.onCountryChange != null) {
                          widget.onCountryChange!(value);
                        }
                      },
                      readOnly: false),
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
                      value: widget.sexInitial,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: missionUsernameTextStyle,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          print(dropdownValue);
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
                controller: emailController,
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
                controller: nameController,
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
                        child: Text(
                          firstContact ?? "",
                          style: missionUsernameTextStyle,
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
              Positioned(
                child: Container(
                  height: 31,
                  child: InternationalPhoneNumberInput(
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
                    },
                    // autoValidateMode:
                    //     AutovalidateMode.onUserInteraction,
                    cursorColor: Colors.black,
                    inputDecoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        filled: true,
                        fillColor: kInputBackGreyColor,
                        contentPadding: EdgeInsets.only(right: 100, left: 100),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                  if (widget.onUsernameChange != null) {
                    widget.onUsernameChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 5),
            _buildTextInput(
                hintText: "NETWORK 名称",
                controller: walletNetworkController,
                onChanged: (value) {
                  if (widget.onUsernameChange != null) {
                    widget.onUsernameChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 5),
            _buildTextInput(
                hintText: "货币- USDT",
                controller: nameController,
                onChanged: (value) {
                  if (widget.onUsernameChange != null) {
                    widget.onUsernameChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 15),
            GestureDetector(
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
                controller: walletNetworkController,
                onChanged: (value) {
                  if (widget.onWalletNetworkChange != null) {
                    widget.onWalletNetworkChange!(value);
                  }
                },
                readOnly: false),
            SizedBox(height: 10),
            _buildTextInput(
                hintText: "USDT 链地址",
                controller: walletAddressController,
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
