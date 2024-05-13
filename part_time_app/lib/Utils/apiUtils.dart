import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class ResponseData {
  final int statusCode;
  final dynamic responseBody;

  ResponseData(this.statusCode, this.responseBody);
}

Future<ResponseData> postRequest(
    String url, Map<String, String> headers, Map<String, dynamic> body) async {
  try {
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    return ResponseData(response.statusCode, utf8.decode(response.bodyBytes));
  } catch (e) {
    throw Exception('Error in postRequest: $e');
  }
}

Future<ResponseData> getRequest(
  String url,
  Map<String, String> headers,
) async {
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    return ResponseData(response.statusCode, utf8.decode(response.bodyBytes));
  } catch (e) {
    throw Exception('Error in getRequest: $e');
  }
}

Future<ResponseData> patchRequest(
    String url, Map<String, String> headers, Map<String, dynamic> body) async {
  try {
    final response = await http.patch(Uri.parse(url),
        headers: headers, body: json.encode(body));

    return ResponseData(response.statusCode, utf8.decode(response.bodyBytes));
  } catch (e) {
    throw Exception('Error in patchRequest: $e');
  }
}

Future<ResponseData> deleteRequest(
    String url, Map<String, String> headers) async {
  try {
    final response = await http.delete(Uri.parse(url), headers: headers);

    return ResponseData(response.statusCode, utf8.decode(response.bodyBytes));
  } catch (e) {
    throw Exception('Error in deleteRequest: $e');
  }
}

Future<Map<String, dynamic>> postFileRequest(File file, String url) async {
  print("check token return profile: $file");
  try {
    // 创建一个MultipartRequest
    var request = http.MultipartRequest('POST', Uri.parse(url));

    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: path.basename(file.path), // Use path.basename
      contentType: MediaType.parse(lookupMimeType(file.path) ?? 'image/jpeg'),
    );

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = json.decode(responseBody);
      print(file.path);
      print(jsonData);
      print("check token return outside: $responseBody");
      return jsonData;
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception('Exception: $e');
  }
}
