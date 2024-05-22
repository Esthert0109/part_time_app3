import 'dart:convert';

import 'package:part_time_app/Utils/apiUtils.dart';

import '../../Constants/apiConstant.dart';
import '../../Model/Task/missionClass.dart';
import '../../Model/User/userModel.dart';
import '../../Utils/sharedPreferencesUtils.dart';

class PaymentServices {
  Future<bool?> createPayment(OrderData paymentData, String billingImage, String? billingUrl)async{
    String url = port + createPaymentUrl;

    String? token = await SharedPreferencesUtils.getToken();
    UserData? userDetails = await SharedPreferencesUtils.getUserDataInfo();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'token': token!
    };

    final Map<String, dynamic> body = {
      "taskId": paymentData.taskId,
	"paymentFromCustomerId": userDetails!.customerId,
	"paymentToCustomerId": "9c7be416-8a95-425f-ab1c-47f7552945ea",
	"paymentType": 0,
	"paymentUsername": userDetails.username,
	"paymentBillingAddress": userDetails.billingAddress,
	"paymentBillingNetwork": userDetails.billingNetwork,
	"paymentBillingCurrency": userDetails.billingCurrency,
	"paymentBillingImage": billingImage,
	"paymentBillingUrl": billingUrl,
	"paymentAmount": paymentData.taskPrepay,
	"paymentFee": paymentData.taskFee,
	"paymentTotalAmount": paymentData.taskAmount,
	"paymentStatus": 1
    };

    try{
      final response = await postRequest(url, headers, body);

      if(response.statusCode == 200){
        Map<String, dynamic> jsonData = json.decode(response.responseBody);
        int responseCode = jsonData['code'];

        if(responseCode == 0){
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }
    }catch(e){
      print("Error in create payment: $e");
      return false;
    }

  }
}