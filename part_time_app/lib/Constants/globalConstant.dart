import 'package:part_time_app/Model/Category/categoryModel.dart';
import 'package:part_time_app/Model/User/userModel.dart';

import '../Model/Advertisement/advertisementModel.dart';
import '../Model/Task/missionClass.dart';
import '../Model/notification/messageModel.dart';

UserData userData = UserData();

// Explore module
List<CategoryListData> exploreCategoryList = [];
List<AdvertisementData> advertisementList = [];
List<TaskClass> missionAvailable = [];
List<TaskClass> missionAvailableAsec = [];
List<TaskClass> missionAvailableDesc = [];

// Message module
NotificationTipsData? notificationTips;
List<NotificationListDate> systemMessageList = [];
List<NotificationListDate> missionMessageList = [];
List<NotificationListDate> paymentMessageList = [];
List<NotificationListDate> publishMessageList = [];
List<NotificationListDate> ticketingMessageList = [];

// Order
List<OrderData> orderIncompleted = [];
List<OrderData> orderWaitReviewed = [];
List<OrderData> orderFailed = [];
List<OrderData> orderWaitPayment = [];
List<OrderData> orderPaid = [];
int orderPage = 1;
