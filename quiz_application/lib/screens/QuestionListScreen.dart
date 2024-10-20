import 'package:flutter/material.dart';
import 'package:quiz_application/models/QuestionInputDto.dart';
import 'package:quiz_application/screens/EditQuestionScreen.dart';
import 'package:quiz_application/services/QuestionService.dart';
import '../widgets/CustomAppBar.dart';
import 'CreateQuestionScreen.dart';

class QuestionListScreen extends StatefulWidget {
  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  late Future<List<QuestionInputDto>> questions;
  final QuestionService questionService = QuestionService();

  // To track which question is tapped to reveal the result
  List<bool> isFlippedList = [];

  @override
  void initState() {
    super.initState();
    questions = questionService.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List of Questions',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<QuestionInputDto>>(
          future: questions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No questions available'));
            } else {
              // Initialize the isFlippedList to track each question's state
              if (isFlippedList.isEmpty) {
                isFlippedList = List.filled(snapshot.data!.length, false);
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final question = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle between showing the question or the result
                        isFlippedList[index] = !isFlippedList[index];
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      // Animation duration
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: isFlippedList[index]
                          ? _buildResultContainer(
                          question, index) // Show result
                          : _buildQuestionContainer(
                          question, index), // Show question
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
            MaterialPageRoute(builder: (context) => CreateQuestionScreen()),
          );
        },
        backgroundColor: Colors.white70,
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }

  // Question content container
  Widget _buildQuestionContainer(QuestionInputDto question, int index) {
    return Container(
      key: ValueKey("question_$index"),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Text('1) ${question.option1}', style: _optionTextStyle()),
          SizedBox(height: 8.0),
          Text('2) ${question.option2}', style: _optionTextStyle()),
          SizedBox(height: 8.0),
          Text('3) ${question.option3}', style: _optionTextStyle()),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text('4) ${question.option4}', style: _optionTextStyle()),
              IconButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditQuestionScreen(questionId: question.id!)), // Ensure ID is not null
                );
              }, icon: Icon(Icons.edit))
            ],
          ),
        ],
      ),
    );
  }

  // Result content container
  Widget _buildResultContainer(QuestionInputDto question, int index) {
    return Container(
      key: ValueKey("result_$index"),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Right Answer: ${question.rightAnswer}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable BoxDecoration for container
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFF151220),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Colors.purple,
        width: 2.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withOpacity(0.5),
          blurRadius: 8.0,
          offset: Offset(0, 0),
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4.0,
          offset: Offset(2, 2),
        ),
      ],
    );
  }

  // Reusable TextStyle for options
  TextStyle _optionTextStyle() {
    return TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }
}
