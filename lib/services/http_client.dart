import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:priyo_quiz/constants/sharedpref_keys.dart';
import 'package:priyo_quiz/services/shared_preference.dart';

class HttpClient {
  Future<Response<dynamic>> postRequest(String url, {
    Object? body,
    // Map<String, String>? headers
  }) async {
    log("POST URL: $url, Body: $body");
    final String? _token = await SharedPreferenceManager
      .instance.getString(SharedPrefKeys.ACCESS_TOKEN);

    try {
      final dio = Dio();

      if(_token != null && _token.isNotEmpty){
        dio.options.headers['authorization'] = "token $_token";
      }

      return await dio.post(
        url, 
        data: body
      );
    } catch (e) {
      throw HttpException("$e");
    }
  }

  Future<Response<dynamic>> getRequest(String url, {
    Object? body,
    // Map<String, String>? headers
  }) async {
    log("GET URL: $url");
    final String? _token = await SharedPreferenceManager
      .instance.getString(SharedPrefKeys.ACCESS_TOKEN);

    try {
      final dio = Dio();
      if(_token != null && _token.isNotEmpty){
        dio.options.headers['authorization'] = "token $_token";
      }

      return await dio.get(url);
    } catch (e) {
      throw HttpException("$e");
    }
  }
}