import 'dart:convert';

import '../models/QuizOutputDto.dart';

class QuizData {

  List<QuizOutputDto> parseQuizzes(String responseBody) {
    // Decode the JSON string
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    // Convert the JSON into a list of QuizOutputDto objects
    return parsed.map<QuizOutputDto>((json) => QuizOutputDto.fromJson(json)).toList();
  }
}
