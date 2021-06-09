import 'dart:convert';

import 'package:priyo_quiz/services/http_client.dart';
import 'package:priyo_quiz/ui/quiz_list/data/models/response.dart';
import 'package:priyo_quiz/utils/http_exception.dart';

class QuizListDataProvider {
  static const baseUrl = "https://quiz-client-api.priyoschool.com";

  Future<List<Quiz>?> getQuizList({
    required int pageCount
  }) async {
    try {
      print("pageCount at provider $pageCount");
      final elementCount = 10;
      final url = "$baseUrl/api/winners?page=$pageCount&size=$elementCount&sort=startAt,desc";

      final response = await HttpClient().getRequest(url);

      if(response.statusCode == 200 && response.data != null){
        return List<Quiz>.from(response.data.map((e) => Quiz.fromJson(e)));
      }

      return null;
    } catch (e) {
      print("Error on getQuizList API $e");
      CustomHttpException(e.toString());
    }
  }
}