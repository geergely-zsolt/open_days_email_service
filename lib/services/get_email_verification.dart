import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/base_response.dart';

// Calls the email verification endpoint. Return a BaseResponse response.
Future<BaseResponse> verifyEmailSvc(String emailVerificationToken) async {
  Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  String uri =
      "https://open-days-thesis.herokuapp.com/open-days/users/email-verification?token=$emailVerificationToken";

  final rawResponse = await http
      .get(
        Uri.parse(uri),
        headers: headers,
      )
      .timeout(const Duration(seconds: 5));

  BaseResponse response;

  if (rawResponse.statusCode == 200) {
    Map<String, dynamic> parsedResponse = jsonDecode(rawResponse.body);
    response = BaseResponse.fromJson(parsedResponse);
  } else {
    try {
      Map<String, dynamic> parsedResponse = jsonDecode(rawResponse.body);
      response = BaseResponse.fromJson(parsedResponse);
    } catch (e) {
      response = BaseResponse();
    }
  }

  return response;
}
