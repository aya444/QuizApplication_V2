import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_application/data/QuizData.dart';
import 'package:quiz_application/models/QuizOutputDto.dart';
import '../models/QuestionOutputDto.dart';
import '../models/QuizInputDto.dart';
import '../models/Response.dart';

class QuizService {
  final String baseUrl = 'http://192.168.1.2:8765/quiz';

  late QuizData quizData;

  QuizService() {
    quizData = QuizData(); // Initialize quizData
  }

  // Create a new quiz
  Future<int> createQuiz(QuizInputDto quizInputDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(quizInputDto.toJson()),
    );

    if (response.statusCode == 201) {
      // Assuming the backend returns the created quiz ID in the response body
      return int.parse(response.body);
    } else {
      throw Exception('Failed to create quiz');
    }
  }

  // Get all quizzes
  Future<List<QuizOutputDto>> fetchQuizzes() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    print(baseUrl);
    if (response.statusCode == 200) {
      return quizData.parseQuizzes(response.body); // Parse response into Quiz objects
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  // Get quiz questions by id
  Future<List<QuestionOutputDto>> getQuizQuestions(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/get-quiz-questions/$id'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((question) => QuestionOutputDto.fromJson(question))
          .toList();
    } else {
      throw Exception('Failed to load quiz questions');
    }
  }

  // Submit quiz responses and get result
  Future<String> submitQuiz(int id, List<Response> responses) async {
    final response = await http.post(
      Uri.parse('$baseUrl/submit/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(responses.map((r) => r.toJson()).toList()),
    );

    if (response.statusCode == 200) {
      String resultString = response.body;
      return resultString;
    } else {
      throw Exception('Failed to submit quiz');
    }
  }
}
