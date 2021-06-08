import 'dart:developer';

import 'package:priyo_quiz/services/http_client.dart';
import 'package:priyo_quiz/ui/auth/data/models/user.dart';
import 'package:priyo_quiz/utils/http_exception.dart';

class AuthDataProvider {
  static const authBaseUrl = "https://accounts.priyo.com";

  Future<UserProfile?> handleSocialSignIn(
    String? token, String? deviceId, String? clientType, String? provider
    ) async {
    try {
      final url = "$authBaseUrl/auth/api/v1/social/login/";
      final response = await HttpClient().postRequest(
        url, 
        body: {
          "token": token,
          "provider": provider,
          "device_id": deviceId,
          "client_type": clientType
        }
      );

      if(response.statusCode == 200){
        final user = UserProfile.fromJson(response.data);
        
        return user;
      }
      return null;

    } catch (e) {
      print("Error on google sign-in through API $e");
      CustomHttpException(e.toString());
    }
  }

  Future<bool?> createOtpOrVerify({
    String? phoneNo, String? otp
    }) async {
    try {
      final url = "$authBaseUrl/auth/api/v1/update-email-phone/";
      final response = await HttpClient().postRequest(
        url, 
        body: {
          "mobile": phoneNo,
          "code": otp
        }
      );

      if(response.statusCode == 200) return true;
      return false;

    } catch (e) {
      print("Error on google sign-in through API $e");
      CustomHttpException(e.toString());
    }
  }
}