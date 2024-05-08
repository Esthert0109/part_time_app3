import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time_app/Components/Button/primaryButtonComponent.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Pages/Main/collectPage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

final ImagePicker _picker = ImagePicker();

void openImagePicker() async {
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    // showLoadingDialog(context);
    // 选择了图像
    File imageFile = File(image.path);
    print("Checking imageFile $imageFile");

    try {
      //  bool isFinish = await customerService.updateProfilePic(imageFile);
      //   if (isFinish == true) {

      //   }
    } catch (e) {
      print("Error updating profile picture: $e");
    }
  } else {
    // 用户取消了选择
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  int currentPage = 1;
  int itemsPerPage = 4;
  bool isLoading = false;
  bool isFirstLaunch = true;
  bool reachEndOfList = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!dataFetchedCollect && !dataEndCollect) {
      // Fetch data only if it hasn't been fetched before
      _loadData();
    }
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _loadData() async {
    if (!isLoading && !reachEndOfList && !dataEndCollect) {
      setState(() {
        isLoading = true;
      });
      // Simulate fetching data
      await Future.delayed(Duration(seconds: 2));
    }
  }

  void _sortMissionAvailable() {
    //control time
    missionAvailableForCollect!
        .sort((a, b) => b.missionDate!.compareTo(a.missionDate!));
  }

  _scrollListener() {
    if (!_scrollController.hasClients || isLoading) return;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    TextEditingController userNicknameController = TextEditingController();
    TextEditingController realNameController = TextEditingController();
    TextEditingController phone1Controller = TextEditingController();
    TextEditingController phone2Controller = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController billing1Controller = TextEditingController();
    TextEditingController billing2Controller = TextEditingController();
    TextEditingController billing3Controller = TextEditingController();
    final _nameFocusNode = FocusNode();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight),
          child: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/common/arrow_back.svg",
                // height: 58,
                // width: 58,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kBackgroundFirstGradientColor,
                    kBackgroundSecondGradientColor
                  ],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            backgroundColor: Color(0xFFF9F9F9),
            title: thirdTitleComponent(
              text: '编辑资料',
            ),
            centerTitle: true,
          ),
        ),
        body: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  print("edit image");
                  openImagePicker();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
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
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kMainWhiteColor,
                  ),
                  child: Form(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 6),
                          child: Text("用户名称", style: editProfileTitleTextStyle),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 15),
                          child: SizedBox(
                              child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                print("object");
                              }
                              return null;
                            },
                            controller: userNicknameController,
                            textInputAction: TextInputAction.next,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              hintText: "",
                              hintStyle: userProfileUIDTextStyle,
                              filled: true,
                              fillColor: kThirdGreyColor,
                              // counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.6),
                              ),
                            ),
                            style: editProfileInputTextStyle,
                          )),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "所在地 (国家)",
                                      style: editProfileTitleTextStyle,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 6, bottom: 12),
                                      child: SizedBox(
                                          child: TextFormField(
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        onEditingComplete: () {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print("object");
                                          }
                                          return null;
                                        },
                                        controller: countryController,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 25,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.all(8),
                                          isDense: true,
                                          hintText: "",
                                          hintStyle: userProfileUIDTextStyle,
                                          filled: true,
                                          fillColor: kThirdGreyColor,
                                          // counterText: '',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.6),
                                          ),
                                        ),
                                        style: editProfileInputTextStyle,
                                      )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "经营范围",
                                      style: editProfileTitleTextStyle,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, bottom: 12),
                                      child: SizedBox(
                                          child: TextFormField(
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        onEditingComplete: () {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print("object");
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 25,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.all(8),
                                          isDense: true,
                                          hintText: "",
                                          hintStyle: userProfileUIDTextStyle,
                                          filled: true,
                                          fillColor: kThirdGreyColor,
                                          // counterText: '',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.6),
                                          ),
                                        ),
                                        style: editProfileInputTextStyle,
                                      )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "性别",
                                      style: editProfileTitleTextStyle,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 6, bottom: 12),
                                      child: SizedBox(
                                          child: TextFormField(
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        onEditingComplete: () {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            print("object");
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 25,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.all(8),
                                          isDense: true,
                                          hintText: "",
                                          hintStyle: userProfileUIDTextStyle,
                                          filled: true,
                                          fillColor: kThirdGreyColor,
                                          // counterText: '',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.6),
                                          ),
                                        ),
                                        style: editProfileInputTextStyle,
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 6),
                          child: Text(
                            "邮箱",
                            style: editProfileTitleTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 15),
                          child: SizedBox(
                              child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                print("object");
                              }
                              return null;
                            },
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              hintText: "",
                              hintStyle: userProfileUIDTextStyle,
                              filled: true,
                              fillColor: kThirdGreyColor,
                              // counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.6),
                              ),
                            ),
                            style: editProfileInputTextStyle,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 6),
                          child: Text(
                            "真实姓名",
                            style: editProfileTitleTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 15),
                          child: SizedBox(
                              child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                print("object");
                              }
                              return null;
                            },
                            controller: realNameController,
                            textInputAction: TextInputAction.next,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              hintText: "",
                              hintStyle: userProfileUIDTextStyle,
                              filled: true,
                              fillColor: kThirdGreyColor,
                              // counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.6),
                              ),
                            ),
                            style: editProfileInputTextStyle,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 6),
                          child: Text(
                            "第一联系方式",
                            style: editProfileTitleTextStyle,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 6),
                          child: Text(
                            "收款信息",
                            style: editProfileTitleTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 15),
                          child: SizedBox(
                              child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                print("object");
                              }
                              return null;
                            },
                            controller: billing1Controller,
                            textInputAction: TextInputAction.next,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              hintText: "",
                              hintStyle: userProfileUIDTextStyle,
                              filled: true,
                              fillColor: kThirdGreyColor,
                              // counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.6),
                              ),
                            ),
                            style: editProfileInputTextStyle,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 15),
                          child: SizedBox(
                              child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                print("object");
                              }
                              return null;
                            },
                            controller: billing2Controller,
                            textInputAction: TextInputAction.next,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              hintText: "",
                              hintStyle: userProfileUIDTextStyle,
                              filled: true,
                              fillColor: kThirdGreyColor,
                              // counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.6),
                              ),
                            ),
                            style: editProfileInputTextStyle,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 15),
                          child: SizedBox(
                              child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                print("object");
                              }
                              return null;
                            },
                            controller: billing3Controller,
                            textInputAction: TextInputAction.next,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              hintText: "",
                              hintStyle: userProfileUIDTextStyle,
                              filled: true,
                              fillColor: kThirdGreyColor,
                              // counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.6),
                              ),
                            ),
                            style: editProfileInputTextStyle,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 6),
                          child: Text("修改密码", style: editProfilePassTextStyle),
                        ),
                      ]))),
              Container(
                  padding:
                      EdgeInsets.only(bottom: 30, top: 5, left: 10, right: 10),
                  decoration: BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  child: primaryButtonComponent(
                    text: "立刻保存",
                    onPressed: () {
                      // print(strings);
                      // setState(() {
                      //   print(selectedIndexName);
                      //   Get.to(
                      //       () => SearchResultPage(
                      //             selectedTags: selectedIndexName,
                      //             byTag: true,
                      //           ),
                      //       transition: Transition.rightToLeft);
                      // });
                    },
                    buttonColor: kMainYellowColor,
                    textStyle: missionCheckoutTotalPriceTextStyle,
                  )),
            ],
          ),
        ));
  }
}
