import 'package:flutter/material.dart';
import 'package:quiz_application/widgets/CustomAppBar.dart';
import 'package:quiz_application/widgets/HomePageButtons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'QuizUp',
        showBackButton: false,
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 70, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Let's get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,

                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 90,),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  HomePageButton(
                    label: 'View Quizzes',
                    onPressed: () {
                      // Navigate to the list of quizzes
                      Navigator.pushNamed(context, '/quizList');
                    },
                  ),
                  // SizedBox(height: 20), // Add spacing between the buttons
                  // HomePageButton(
                  //   label: 'Create Quiz',
                  //   onPressed: () {
                  //     // Navigate to the create quiz page
                  //     Navigator.pushNamed(context, '/createQuiz');
                  //   },
                  // ),
                  SizedBox(height: 20), // Add spacing between the buttons
                  HomePageButton(
                    label: 'View Questions',
                    onPressed: () {
                      // Navigate to the create quiz page
                      Navigator.pushNamed(context, '/questionList');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
