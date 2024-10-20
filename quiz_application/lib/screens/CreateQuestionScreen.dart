import 'package:flutter/material.dart';
import 'package:quiz_application/models/QuestionInputDto.dart';
import 'package:quiz_application/services/QuestionService.dart';

class CreateQuestionScreen extends StatefulWidget {
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  QuestionService questionService = QuestionService();

  String questionTitle = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';
  String rightAnswer = '';
  String category = '';
  String difficultyLevel = '';
  bool isLoading = false; // To manage loading state

  // Method to create the quiz using the QuizInputDto
  Future<String> createQuestion(QuestionInputDto questionInputDto) async {
    return questionService.createQuestion(questionInputDto);
  }

  // Submit form and handle quiz creation
  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form input
      setState(() {
        isLoading = true; // Show loading spinner
      });

      // Create a QuizInputDto object
      QuestionInputDto questionInputDto = QuestionInputDto(
          questionTitle: questionTitle,
          option1: option1,
          option2: option2,
          option3: option3,
          option4: option4,
          difficultyLevel: difficultyLevel,
          category: category,
          rightAnswer: rightAnswer);

      try {
        String? response =
            await createQuestion(questionInputDto); // Allow quizId to be null
        setState(() {
          isLoading = false; // Stop loading spinner
        });

        if (response != null) {
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Question Created!", textAlign: TextAlign.center,)),
          );

          // Reset the form fields to clear the input data
          _formKey.currentState!.reset();
          setState(() {
            questionTitle = '';
            option1 = '';
            option2 = '';
            option3 = '';
            option4 = '';
            rightAnswer = '';
            category = '';
            difficultyLevel = '';
          });
        } else {
          // Handle case where quizId is null
          throw Exception("Question creation failed!");
        }
      } catch (e) {
        setState(() {
          isLoading = false; // Stop loading spinner
        });

        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating question: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView( // Makes the content scrollable
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Question Title',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the question title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            questionTitle = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Option 1',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the first option';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            option1 = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Option 2',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the second option';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            option2 = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Option 2',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the third option';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            option3 = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Option 4',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the forth option';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            option4 = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Right Answer',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the right answer';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            rightAnswer = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the category';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            category = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Difficulty Level',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .white70), // White border when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.withOpacity(0.7),
                              // Illuminating purple when focused
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the difficulty level';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            difficultyLevel = value; // Handle the value safely
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: submitForm,
                          child: Text('Create Question'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            // Button color
                            fixedSize: Size(180, 50),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ), // content padding inside button
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
      ),
    );
  }
}
