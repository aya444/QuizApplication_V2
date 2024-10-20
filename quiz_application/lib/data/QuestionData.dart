import 'dart:convert';

import 'package:quiz_application/models/QuestionInputDto.dart';

class QuestionData {

  List<QuestionInputDto> parseQuestions(String responseBody) {
    // Decode the JSON string
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    // Convert the JSON into a list of QuizOutputDto objects
    return parsed.map<QuestionInputDto>((json) => QuestionInputDto.fromJson(json)).toList();
  }

  QuestionInputDto parseQuestion(String responseBody) {
    // Decode the JSON string
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    // Convert the JSON into a QuizOutputDto object
    return parsed.map<QuestionInputDto>((json) => QuestionInputDto.fromJson(json));
  }
}
