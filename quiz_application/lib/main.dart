import 'package:flutter/material.dart';
import 'package:quiz_application/screens/CreateQuizScreen.dart';
import 'package:quiz_application/screens/HomeScreen.dart';
import 'package:quiz_application/screens/QuestionListScreen.dart';
import 'package:quiz_application/screens/QuizListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QuizUp',
        routes: {
          '/': (context) => HomeScreen(),
          '/quizList': (context) => QuizListScreen(),
          '/createQuiz': (context) => CreateQuizScreen(),
          '/questionList': (context) => QuestionListScreen(),
        },
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.purple.withOpacity(0.5),
              // Set the app bar color here
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
              toolbarHeight: 60,
              centerTitle: true,
              shadowColor: Colors.deepPurple,
              iconTheme: IconThemeData(
                  color: Colors.white, // Change the back icon color here
                  size: 30),
            ),
            scaffoldBackgroundColor: const Color(0xFF151220)),
        debugShowCheckedModeBanner: false);
  }
}