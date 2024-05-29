import 'dart:math';

import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class ChatService {
  void sendMessage(String peopleToChat) async {
    // 创建文本消息
    V2TimValueCallback<V2TimMsgCreateInfoResult> createTextMessageRes =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(
              text: "嗨!你好，请还钱", // 文本信息
            );

    if (createTextMessageRes.code == 0) {
      // 文本信息创建成功
      String? id = createTextMessageRes.data?.id;
      // 发送文本消息
      // 在sendMessage时，若只填写receiver则发个人用户单聊消息
      //                 若只填写groupID则发群组消息
      //                 若填写了receiver与groupID则发群内的个人用户，消息在群聊中显示，只有指定receiver能看见
      V2TimValueCallback<V2TimMessage> sendMessageRes =
          await TencentImSDKPlugin.v2TIMManager.getMessageManager().sendMessage(
              id: id!, // 创建的messageid
              receiver: peopleToChat, // 接收人id
              groupID: "", // 接收群组id
              priority: MessagePriorityEnum.V2TIM_PRIORITY_DEFAULT, // 消息优先级
              onlineUserOnly:
                  false, // 是否只有在线用户才能收到，如果设置为 true ，接收方历史消息拉取不到，常被用于实现“对方正在输入”或群组里的非重要提示等弱提示功能，该字段不支持 AVChatRoom。
              isExcludedFromUnreadCount: false, // 发送消息是否计入会话未读数
              isExcludedFromLastMessage: false, // 发送消息是否计入会话 lastMessage
              needReadReceipt:
                  false, // 消息是否需要已读回执（只有 Group 消息有效，6.1 及以上版本支持，需要您购买旗舰版套餐）
              offlinePushInfo: OfflinePushInfo(), // 离线推送时携带的标题和内容
              cloudCustomData: "", // 消息云端数据，消息附带的额外的数据，存云端，消息的接收者可以访问到
              localCustomData:
                  "" // 消息本地数据，消息附带的额外的数据，存本地，消息的接收者不可以访问到，App 卸载后数据丢失
              );
      if (sendMessageRes.code == 0) {
        // 发送成功
      }
    }
  }

  // void sendImageMessage() async {
  //   V2TimValueCallback<V2TimMsgCreateInfoResult> createImageMessageRes =
  //       await TencentImSDKPlugin.v2TIMManager
  //           .getMessageManager()
  //           .createImageMessage(
  //               imagePath:
  //                   "https://live-stream-1321239144.cos.ap-singapore.myqcloud.com/head/c733c0a4f2004763965b45d4444f524e.png",
  //               imageName: "test");
  //   if (createImageMessageRes.code == 0) {
  //     String? id = createImageMessageRes.data?.id;
  //     V2TimValueCallback<V2TimMessage> sendMessageRes = await TencentImSDKPlugin
  //         .v2TIMManager
  //         .getMessageManager()
  //         .sendMessage(id: id!, receiver: "456", groupID: "");
  //     if (sendMessageRes.code == 0) {
  //       // 发送成功
  //     }
  //   }
  // }
}
