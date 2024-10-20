import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_application/data/QuestionData.dart';
import 'package:quiz_application/models/QuestionInputDto.dart';
import '../models/QuestionOutputDto.dart';
import '../models/QuizInputDto.dart';

class QuestionService {
  final String baseUrl = 'http://192.168.1.2:8765/question';

  late QuestionData questionData;

  QuestionService() {
    questionData = QuestionData(); // Initialize quizData
  }

  // Create a new question
  Future<String> createQuestion(QuestionInputDto questionInputDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(questionInputDto.toJson()),
    );

    if (response.statusCode == 201) {
      // Assuming the backend returns the created quiz ID in the response body
      return response.body;
    } else {
      throw Exception('Failed to create question');
    }
  }

  // Get all questions
  Future<List<QuestionInputDto>> fetchQuestions() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    print(baseUrl);
    if (response.statusCode == 200) {
      return questionData
          .parseQuestions(response.body); // Parse response into Quiz objects
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // Get all questions
  Future<QuestionInputDto> fetchQuestionById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      return QuestionInputDto.fromJson(json.decode(response.body)); // Parse response into Quiz objects
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // Get questions by category
  Future<List<QuestionInputDto>> getQuizQuestions(String cat) async {
    final response = await http.get(Uri.parse('$baseUrl/category/$cat'));

    if (response.statusCode == 200) {
      return questionData.parseQuestions(response.body);
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // Function to edit a question
  Future<String> editQuestion(
      int id, QuestionInputDto updatedQuestionInputDto) async {
    final url = Uri.parse('$baseUrl/edit/$id');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(updatedQuestionInputDto.toJson());

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to edit question: ${response.body}');
    }
  }

  Future<String?> deleteQuestion(int id) async {
    final url = Uri.parse('$baseUrl/delete/$id');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Return success message
        return jsonDecode(response.body);
      } else {
        // Handle error if not successful
        throw Exception('Failed to delete question: ${response.body}');
      }
    } catch (e) {
      print('Error deleting question: $e');
      return null;
    }
  }
}
