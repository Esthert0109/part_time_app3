import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time_app/Components/Button/PrimaryButtonComponent.dart';
import 'package:part_time_app/Components/Card/userDetailCardComponent.dart';
import 'package:part_time_app/Components/Loading/aboutUsPageLoading.dart';
import 'package:part_time_app/Components/Loading/editProfilePageLoading.dart';
import 'package:part_time_app/Components/Title/secondaryTitleComponent.dart';
import 'package:part_time_app/Components/Title/thirdTitleComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Constants/textStyleConstant.dart';
import 'package:part_time_app/Model/AboutUs/aboutUsModel.dart';
import 'package:part_time_app/Services/AboutUs/aboutUsServices.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isLoading = true;
  AboutUsModel? aboutUs;
  AboutUsData? aboutData;
  final AboutUsServices aboutUsServices = AboutUsServices();
  String logo = '';
  String workingTime = '';
  String contactNumber = '';
  String email = '';
  String businessCooperation = '';
  String companyName = '';

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 0), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    fetchAboutUsDetails();
  }

  Future<void> fetchAboutUsDetails() async {
    final aboutUsModel = await aboutUsServices.aboutUsDetails();
    if (aboutUsModel != null) {
      setState(() {
        logo = aboutUsModel.data!.logo;
        workingTime = aboutUsModel.data?.workingTime ?? '无法显示';
        contactNumber = aboutUsModel.data?.contactNumber ?? '无法显示';
        email = aboutUsModel.data?.email ?? '无法显示';
        businessCooperation = aboutUsModel.data?.businessCooperation ?? '无法显示';
        companyName = aboutUsModel.data?.companyName ?? '无法显示';
      });
    } else {
      print('Failed to load about us details');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/common/arrow_back.svg",
            ),
            onPressed: () {
              Get.back();
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
                  kBackgroundSecondGradientColor,
                ],
                stops: [0.5, 1.0],
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF9F9F9),
          title: const thirdTitleComponent(
            text: '关于我们',
          ),
          centerTitle: true,
        ),
      ),
      body: isLoading
          ? const AboutUsLoadingComponent()
          : Column(
              children: [
                const SizedBox(height: 20),
                Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      logo,
                      height: 70,
                      width: 70,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 70,
                          width: 70,
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: const Text(
                            '无法显示',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    )),
                const SizedBox(height: 3),
                const Text(
                  '版本信息',
                  style: aboutUsTextStyle1,
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text('联系方式', style: aboutUsTextStyle2),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    color: kMainWhiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '工作时间： ',
                            style: aboutUsTextStyle3,
                          ),
                          Flexible(
                            child: Text(
                              workingTime,
                              style: aboutUsTextStyle4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '联系电话： ',
                            style: aboutUsTextStyle3,
                          ),
                          Flexible(
                            child: Text(
                              contactNumber,
                              style: aboutUsTextStyle4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '举报邮箱： ',
                            style: aboutUsTextStyle3,
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: email,
                                    style: aboutUsTextStyle4,
                                  ),
                                  TextSpan(
                                    text: '\n(请提供您的用户ID以及详细描述所咨询的问题)',
                                    style: aboutUsTextStyle5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '商务合作QQ： ',
                            style: aboutUsTextStyle3,
                          ),
                          Flexible(
                            child: Text(
                              businessCooperation,
                              style: aboutUsTextStyle4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '公司名称： ',
                            style: aboutUsTextStyle3,
                          ),
                          Flexible(
                            child: Text(
                              companyName,
                              style: aboutUsTextStyle4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'APP名字 - 悬赏、互助、兼职平台',
                        style: aboutUsTextStyle2,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '若影响到您的合理权益，可通过举报邮箱与我们取得联系。如果您有项目需要在APP中推广，也可以随时联系我们。',
                        style: aboutUsTextStyle4,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('《用户注册协议》');
                            },
                            child: const Text(
                              '《用户注册协议》',
                              style: aboutUsTextStyle6,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('《隐私政策》');
                            },
                            child: const Text(
                              '《隐私政策》',
                              style: aboutUsTextStyle6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
