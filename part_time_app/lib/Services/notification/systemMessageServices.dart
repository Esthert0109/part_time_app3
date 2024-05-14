// import 'dart:convert';
// import 'package:part_time_app/Utils/apiUtils.dart';
// import '../../Constants/apiConstant.dart';
// import '../../Model/notification/messageModel.dart';

// class SystemMessageServices {
//   Future<MessageModel?> fetchSystemMessage() async {
//     String url = port + systemMessage;
//     final Map<String, String> headers = {
//       'Content-Type': 'application/json; charset=utf-8',
//     };
//     try {
//       final response = await getRequest(url, headers);
//       print(response.responseBody); // Add this line to print the response data
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.responseBody);
//         if (jsonData['data'] != null &&
//             jsonData['data'] is List<dynamic> &&
//             jsonData['data'].isNotEmpty) {
//           // List of messages format
//           print("300");
//           final messages = (jsonData['data'])
//               .map<MessageModel>(
//                   (messageData) => MessageModel.fromJson(messageData))
//               .toList();
//           print("400");
//           return messages;
//         } else {
//           // Handle unexpected data format (print response body for debugging)
//           print("Response Body: ${response.responseBody}");
//           throw Exception('No system message data found');
//         }
//       } else {
//         // Handle other status codes (throw exception)
//         throw Exception(
//             'Failed to fetch system messages. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Catch any errors during the HTTP request
//       throw Exception('Failed to fetch system messages: $e');
//     }
//   }
// }
