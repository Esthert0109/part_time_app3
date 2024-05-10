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

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isLoading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
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
                // height: 58,
                // width: 58,
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
                    kBackgroundSecondGradientColor
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
                    child: SvgPicture.asset(
                      "assets/profile/aboutUs_logo.svg",
                      height: 70,
                      width: 70,
                    ),
                  ),
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
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                        color: kMainWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '工作时间： ',
                              style: aboutUsTextStyle3,
                            ),
                            Flexible(
                              child: Text(
                                '工作日(周一至周四 8:30 - 12:00, 13:30 - 17:30, 周五 8:30 - 12:00)',
                                style: aboutUsTextStyle4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '联系电话： ',
                              style: aboutUsTextStyle3,
                            ),
                            Flexible(
                              child: Text(
                                '010 - 86934021',
                                style: aboutUsTextStyle4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '举报邮箱： ',
                              style: aboutUsTextStyle3,
                            ),
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'jubao@gmail.cc\n',
                                      style: aboutUsTextStyle4,
                                    ),
                                    TextSpan(
                                      text: '(请提供您的用户ID以及详细描述所咨询的问题)',
                                      style: aboutUsTextStyle5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '商务合作QQ： ',
                              style: aboutUsTextStyle3,
                            ),
                            Flexible(
                              child: Text(
                                '3067183171',
                                style: aboutUsTextStyle4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '公司名称： ',
                              style: aboutUsTextStyle3,
                            ),
                            Flexible(
                              child: Text(
                                '北京酷酷信息服务有限公司',
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
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
