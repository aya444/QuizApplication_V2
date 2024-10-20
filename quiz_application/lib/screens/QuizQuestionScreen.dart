import 'package:flutter/material.dart';
import '../models/QuestionOutputDto.dart';
import '../services/QuizService.dart';
import '../widgets/CustomAppBar.dart';
import 'ResultScreen.dart';
import 'package:quiz_application/models/Response.dart'; // Ensure this is the correct path

class QuestionListScreen extends StatefulWidget {
  final int quizId;

  const QuestionListScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  late Future<List<QuestionOutputDto>> questionFuture;
  late List<QuestionOutputDto> questions;
  late List<int?> selectedAnswers; // Track selected answers
  int currentQuestionIndex = 0;
  late QuizService quizService;

  @override
  void initState() {
    super.initState();
    quizService = QuizService();
    questionFuture = fetchQuestions(); // Initialize questionFuture here
  }

  Future<List<QuestionOutputDto>> fetchQuestions() async {
    questions = await quizService.getQuizQuestions(widget.quizId);
    selectedAnswers = List.filled(questions.length, null); // Initialize answers list
    return questions;
  }

  void navigateToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void navigateToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void submitQuiz() async {
    List<Response> responses = [];

    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] != null) {
        responses.add(
          Response(
            id: questions[i].id,
            response: selectedAnswers[i] == 0
                ? questions[i].option1
                : selectedAnswers[i] == 1
                ? questions[i].option2
                : selectedAnswers[i] == 2
                ? questions[i].option3
                : questions[i].option4,
          ),
        );
      }
    }

    String score = await quizService.submitQuiz(widget.quizId, responses);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen(result: score)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Questions for Quiz ${widget.quizId}',
        showBackButton: false,
      ),
      body: FutureBuilder<List<QuestionOutputDto>>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No questions available'));
          } else {
            final currentQuestion = snapshot.data![currentQuestionIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${snapshot.data!.length}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    currentQuestion.questionTitle,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  // Display options as RadioListTiles
                  Expanded(
                    child: Column(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: selectedAnswers[currentQuestionIndex] == i
                                        ? [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.4),
                                        blurRadius: 10.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(0, 0),
                                      ),
                                    ]
                                        : [],
                                  ),
                                  child: Radio<int?>(
                                    value: i,
                                    groupValue: selectedAnswers[currentQuestionIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAnswers[currentQuestionIndex] = value;
                                      });
                                    },
                                    activeColor: Colors.purple, // Active radio button color
                                  ),
                                ),
                                SizedBox(width: 7), // Space between radio and text
                                Expanded(
                                  child: Text(
                                    i == 0
                                        ? currentQuestion.option1
                                        : i == 1
                                        ? currentQuestion.option2
                                        : i == 2
                                        ? currentQuestion.option3
                                        : currentQuestion.option4,
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // SizedBox(height: 200,)
                      ],
                    ),
                  ),
                  // Navigation and submission buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: navigateToPreviousQuestion,
                          child: Text('Back'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Button color
                            fixedSize: Size(120, 50),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            textStyle: TextStyle(fontSize: 17, color: Colors.purple, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),//content padding inside button
                          )
                          ),
                      ElevatedButton(
                        onPressed: currentQuestionIndex < questions.length - 1
                            ? navigateToNextQuestion
                            : submitQuiz,
                        child: Text(currentQuestionIndex == questions.length - 1
                            ? 'Submit'
                            : 'Next'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Button color
                            fixedSize: Size(120, 50),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            textStyle: TextStyle(fontSize: 17, color: Colors.purple, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),//content padding inside button
                          )
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
