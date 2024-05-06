import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/Message/user/chat.dart';
import 'package:part_time_app/Pages/Message/user/contact.dart';
import 'package:part_time_app/Pages/Message/user/conversation.dart';
import 'package:part_time_app/Pages/Message/user/tencent_page.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import 'package:tencent_cloud_chat_uikit/ui/controller/tim_uikit_chat_controller.dart';
import 'package:tencent_cloud_chat_uikit/ui/controller/tim_uikit_conversation_controller.dart';
import 'package:tencent_cloud_chat_uikit/ui/utils/platform.dart';
import 'package:tencent_super_tooltip/tencent_super_tooltip.dart';

class UserMessagePage extends StatefulWidget {
  final int pageIndex;
  const UserMessagePage({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  State<UserMessagePage> createState() => _UserMessagePageState();
}

class _UserMessagePageState extends State<UserMessagePage> {
  bool hasInit = false;
  var subscription;
  bool hasInternet = true;
  int currentIndex = 0;
  SuperTooltip? tooltip;
  final CoreServicesImpl _coreInstance = TIMUIKitCore.getInstance();
  final V2TIMManager _sdkInstance = TIMUIKitCore.getSDKInstance();
  final TIMUIKitConversationController _conversationController =
      TIMUIKitConversationController();
  final TIMUIKitChatController _timuiKitChatController =
      TIMUIKitChatController();
  String pageName = "";
  bool isNeedMoveToConversation = false;

  getLoginUserInfo() async {
    if (PlatformUtils().isWeb) {
      return;
    }
    final res = await _sdkInstance.getLoginUser();
    if (res.code == 0) {
      final result = await _sdkInstance.getUsersInfo(userIDList: [res.data!]);

      // if (result.code == 0) {
      //   Provider.of<LoginUserInfo>(context, listen: false)
      //       .setLoginUserInfo(result.data![0]);
      // }
    }
  }

  _initTrtc() async {
    // final TUICallKit _callKit = TUICallKit.instance;
    final _tuiLogin = TUILogin.instance;
    final loginInfo = _coreInstance.loginInfo;
    final userID = loginInfo.userID;
    final userSig = loginInfo.userSig;
    final sdkAppId = loginInfo.sdkAppID;
    // _callKit.enableFloatWindow(true);
    _tuiLogin.login(
        sdkAppId,
        userID,
        userSig,
        TUICallback(onSuccess: () {
          print("callkit--- success");
        }, onError: (int code, String message) {
          print("callkit--- onError $message");
        }));
  }

  uploadOfflinePushInfoToken() async {
    if (PlatformUtils().isMobile) {
      // ChannelPush.requestPermission();
      Future.delayed(const Duration(seconds: 5), () async {
        //final bool isUploadSuccess = await ChannelPush.uploadToken(PushConfig.appInfo);
        // print("Push token upload result: $isUploadSuccess");
      });
    }
  }

  @override
  initState() {
    super.initState();
    currentIndex = widget.pageIndex;
    _initTrtc();
    setState(() {});
    getLoginUserInfo();
    initOfflinePush();
  }

  initOfflinePush() async {
    if (PlatformUtils().isMobile) {
      // await ChannelPush.init(handleClickNotification);
      uploadOfflinePushInfoToken();
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  void handleClickNotification(Map<String, dynamic> msg) async {
    String ext = TencentUtils.checkString(msg['ext']) ??
        TencentUtils.checkString(msg['data']['ext']) ??
        "";
    Map<String, dynamic> extMsp = jsonDecode(ext);
    String convId = extMsp["conversationID"] ?? "";
    final currentConvID = _timuiKitChatController.getCurrentConversation();
    if (convId.split("_").length < 2 || currentConvID == convId.split("_")[1]) {
      return;
    }
    final targetConversationRes = await TencentImSDKPlugin.v2TIMManager
        .getConversationManager()
        .getConversation(conversationID: convId);

    V2TimConversation? targetConversation = targetConversationRes.data;

    if (targetConversation != null) {
      // ChannelPush.clearAllNotification();
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(
                selectedConversation: targetConversation,
              ),
            ));
      });
    }
  }

  List<NavigationBarData> getBottomNavigatorList(BuildContext context, theme) {
    final List<NavigationBarData> bottomNavigatorList = [
      NavigationBarData(
        widget: Conversation(
          key: conversationKey,
          conversationController: _conversationController,
        ),
        title: TIM_t("消息"),
        selectedIcon: Stack(
          clipBehavior: Clip.none,
          children: [
            ColorFiltered(
              child: Image.asset(
                "assets/chat_active.png",
                width: 24,
                height: 24,
              ),
              colorFilter: ColorFilter.mode(
                  theme.primaryColor ?? CommonColor.primaryColor,
                  BlendMode.srcATop),
            ),
            Positioned(
              top: -5,
              right: -6,
              child: UnconstrainedBox(
                child: TIMUIKitConversationTotalUnread(width: 16, height: 16),
              ),
            )
          ],
        ),
        unselectedIcon: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              "assets/chat.png",
              width: 24,
              height: 24,
            ),
            Positioned(
              top: -5,
              right: -6,
              child: UnconstrainedBox(
                child: TIMUIKitConversationTotalUnread(width: 16, height: 16),
              ),
            )
          ],
        ),
      ),
      NavigationBarData(
        widget: const Contact(),
        title: TIM_t("通讯录"),
        selectedIcon: Stack(
          clipBehavior: Clip.none,
          children: [
            ColorFiltered(
              child: Image.asset(
                "assets/contact_active.png",
                width: 24,
                height: 24,
              ),
              colorFilter: ColorFilter.mode(
                  theme.primaryColor ?? CommonColor.primaryColor,
                  BlendMode.srcATop),
            ),
            const Positioned(
              top: -5,
              right: -6,
              child: UnconstrainedBox(
                child: TIMUIKitUnreadCount(
                  width: 16,
                  height: 16,
                ),
              ),
            )
          ],
        ),
        unselectedIcon: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              "assets/contact.png",
              width: 24,
              height: 24,
            ),
            const Positioned(
              top: -5,
              right: -6,
              child: UnconstrainedBox(
                child: TIMUIKitUnreadCount(
                  width: 16,
                  height: 16,
                ),
              ),
            )
          ],
        ),
      ),
      // NavigationBarData(
      //   widget: const Live(),
      //   title: TIM_t("直播"),
      //   selectedIcon: ColorFiltered(
      //       child: const Icon(
      //         Icons.live_tv_rounded,
      //         size: 24,
      //       ),
      //       colorFilter: ColorFilter.mode(
      //           theme.primaryColor ?? CommonColor.primaryColor,
      //           BlendMode.srcATop)),
      //   unselectedIcon: const Icon(
      //     Icons.live_tv_rounded,
      //     size: 24,
      //   ),
      // ),
      // NavigationBarData(
      //   widget: const MyProfile(),
      //   title: TIM_t("我的"),
      //   selectedIcon: ColorFiltered(
      //       child: Image.asset(
      //         "assets/profile_active.png",
      //         width: 24,
      //         height: 24,
      //       ),
      //       colorFilter: ColorFilter.mode(
      //           theme.primaryColor ?? CommonColor.primaryColor,
      //           BlendMode.srcATop)),
      //   unselectedIcon: Image.asset(
      //     "assets/profile.png",
      //     width: 24,
      //     height: 24,
      //   ),
      // ),
    ];

    return bottomNavigatorList;
  }

  List<NavigationBarData> bottomNavigatorList(theme) {
    return getBottomNavigatorList(context, theme);
  }

  // /关闭
  close() {
    Navigator.of(context).pop();
  }

  void _changePage(int index, BuildContext context) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
        if (index == 1) {
          pageName = 'concat';
        }
        // if (index == 2) {
        //   pageName = 'userProfile';
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonColor.defaultTheme;
    return TencentPage(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset("assets/common/back_button.svg"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color(0xFFFCEEA5),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            shadowColor: theme.weakDividerColor,
            elevation: currentIndex == 0 ? 0 : 1,
            automaticallyImplyLeading: false,
            // title: getTitle(localSetting),
            scrolledUnderElevation: 0.0,
            surfaceTintColor: Color(0xFFFCEEA5),
            title: Text(
              "用户消息",
              style: TextStyle(
                fontFamily: 'PingFang SC',
                fontSize: 18,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500,
                height: 1.4, // Adjust the value to match line-height
                letterSpacing: 0.12,
              ),
            ),
            centerTitle: true,
            // flexibleSpace: Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(colors: [
            //       theme.lightPrimaryColor ?? CommonColor.lightPrimaryColor,
            //       theme.primaryColor ?? CommonColor.primaryColor
            //     ]),
            //   ),
            // ),
            //SHOW ADD BUTTON
            // actions: [
            //   if ([0, 1].contains(currentIndex))
            //     Builder(builder: (BuildContext c) {
            //       return IconButton(
            //           onPressed: () {
            //             _showTooltip(c);
            //           },
            //           icon: const Icon(
            //             Icons.add_circle_outline,
            //             color: Colors.white,
            //           ));
            //     })
            // ],
          ),
          body: IndexedStack(
            index: currentIndex,
            children:
                bottomNavigatorList(theme).map((res) => res.widget!).toList(),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: List.generate(
          //     bottomNavigatorList(theme).length,
          //     (index) => BottomNavigationBarItem(
          //       icon: index == currentIndex
          //           ? bottomNavigatorList(theme)[index].selectedIcon
          //           : bottomNavigatorList(theme)[index].unselectedIcon,
          //       label: bottomNavigatorList(theme)[index].title,
          //     ),
          //   ),
          //   currentIndex: currentIndex,
          //   type: BottomNavigationBarType.fixed,
          //   onTap: (index) {
          //     _changePage(index, context);
          //     if (isNeedMoveToConversation) {
          //       if (index == 0 && currentIndex == 0) {
          //         conversationKey.currentState
          //             ?.scrollToNextUnreadConversation();
          //       }
          //     }
          //     isNeedMoveToConversation = true;
          //     Future.delayed(const Duration(milliseconds: 300), () {
          //       isNeedMoveToConversation = false;
          //     });
          //   },
          //   selectedItemColor: theme.primaryColor,
          //   unselectedItemColor: Colors.grey,
          //   backgroundColor: theme.weakBackgroundColor,
          // )
        ),
        name: pageName);
  }
}

class NavigationBarData {
  /// 未选择时候的图标
  final Widget unselectedIcon;

  /// 选择后的图标
  final Widget selectedIcon;

  /// 标题内容
  final String title;

  /// 页面组件
  final Widget? widget;

  final ValueChanged<int>? onTap;

  final int? index;

  NavigationBarData(
      {required this.unselectedIcon,
      required this.selectedIcon,
      required this.title,
      this.widget,
      this.onTap,
      this.index});
}
