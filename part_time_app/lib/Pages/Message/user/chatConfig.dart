import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

import 'GenerateUserSig.dart';

final int _sdkAppID = 20008772; // 前置条件中创建的IM应用SDKAppID
// initAndLoginIm() {
//   TencentImSDKPlugin.v2TIMManager.initSDK(
//       sdkAppID: _sdkAppID,
//       loglevel: LogLevelEnum.V2TIM_LOG_ALL,
//       listener: V2TimSDKListener());
//   TencentImSDKPlugin.v2TIMManager
//       .login(userID: _loginUserID, userSig: _userSig);
// }

initAndLoginIm() {
  TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: _sdkAppID,
      loglevel: LogLevelEnum.V2TIM_LOG_ALL,
      listener: V2TimSDKListener());
}

Future<bool> userTencentLogin(String userID) async {
  final CoreServicesImpl coreInstance = TIMUIKitCore.getInstance();

  int sdkAppId = 20008772;
  String key =
      "3f64ecc4094e9caffbcea88eed1a018339d000f4e9805d2a61f445879381c092";

  GenerateTestUserSig generateTestUserSig = GenerateTestUserSig(
    sdkappid: sdkAppId,
    key: key,
  );

  String userSig =
      generateTestUserSig.genSig(identifier: userID, expire: 99999);

  var data = await coreInstance.login(
    userID: userID,
    userSig: userSig,
  );

  // await coreInstance.setSelfInfo(
  //     userFullInfo: V2TimUserFullInfo.fromJson({
  //   "nickName": nickname,
  // }));

  if (data.code != 0) {
    print("login tencent error");
    return false; // Return false if login failed
  }

  return true; // Return true if login was successful
}

Future<bool> setNickNameTencent(String userID, String nickName) async {
  final CoreServicesImpl coreInstance = TIMUIKitCore.getInstance();
  bool isChangeNickname = await userTencentLogin(userID);

  if (isChangeNickname) {
    V2TimCallback setSelfInfoRes = await coreInstance.setSelfInfo(
        userFullInfo: V2TimUserFullInfo.fromJson({
      "nickName": nickName,
    }));
    if (setSelfInfoRes.code == 0) {
      return true;
    }
    return false;
  }
  return false;
}

Future<bool> setAvatarTencent(String userID, String avatar) async {
  final CoreServicesImpl coreInstance = TIMUIKitCore.getInstance();
  bool isChangeAvatar = await userTencentLogin(userID);

  if (isChangeAvatar) {
    V2TimCallback setSelfInfoRes = await coreInstance.setSelfInfo(
        userFullInfo: V2TimUserFullInfo.fromJson({
      "faceUrl": avatar,
    }));
    if (setSelfInfoRes.code == 0) {
      return true;
    }
    return false;
  }
  return false;
}

Future<bool> registerTencent(
    String userID, String nickName, String avatar) async {
  final CoreServicesImpl coreInstance = TIMUIKitCore.getInstance();
  bool isChangeRegister = await userTencentLogin(userID);

  if (isChangeRegister) {
    V2TimCallback setSelfInfoRes = await coreInstance.setSelfInfo(
        userFullInfo: V2TimUserFullInfo.fromJson(
            {"nickName": nickName, "faceUrl": avatar}));
    if (setSelfInfoRes.code == 0) {
      return true;
    }
    return false;
  }
  return false;
}
