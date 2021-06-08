import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class HttpClient {
  Future<Response<dynamic>> postRequest(String url, {
    Object? body,
    // Map<String, String>? headers
  }) async {
    // final parsedUri = Uri.parse(url);
    log("POST URL: $url, Body: $body");
    // return http.post(parsedUri,body:body,headers: headers);
    try {
      return await Dio().post(url, data: body);
    } catch (e) {
      throw HttpException("$e");
    }
  }
}