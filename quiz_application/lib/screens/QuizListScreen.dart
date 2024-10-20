import 'package:flutter/material.dart';
import '../models/QuizOutputDto.dart';
import '../services/QuizService.dart';
import '../widgets/CustomAppBar.dart';
import 'CreateQuizScreen.dart';
import 'QuizQuestionScreen.dart'; // Import your QuestionListScreen

class QuizListScreen extends StatefulWidget {
  @override
  _QuizListScreenState createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  late Future<List<QuizOutputDto>> quizzes;
  final QuizService quizService = QuizService(); // Initialize the service

  @override
  void initState() {
    super.initState();
    quizzes = quizService.fetchQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List of Quizzes',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<QuizOutputDto>>(
          future: quizzes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No quizzes available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final quiz = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the QuestionListScreen with the quiz ID
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionListScreen(quizId: quiz.id),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF151220), // Set background color
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.purple, // Purple border color
                          width: 2.0, // Border width
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.5),
                            // Purple shadow for glowing effect
                            blurRadius: 8.0,
                            // Increase blur radius for a more pronounced glow
                            offset: Offset(0, 0),
                            // Centered shadow
                            spreadRadius:
                                1.0, // Add spread radius for more glow effect
                          ),
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            quiz.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CreateQuizScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateQuizScreen()),
          );
        },
        backgroundColor: Colors.white70,
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }
}
