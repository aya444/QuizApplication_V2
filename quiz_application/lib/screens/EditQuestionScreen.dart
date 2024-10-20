import 'package:flutter/material.dart';
import 'package:quiz_application/services/QuestionService.dart';
import 'package:quiz_application/services/QuizService.dart';
import '../models/QuestionInputDto.dart'; // Import the model for editing

class EditQuestionScreen extends StatefulWidget {
  final int questionId; // ID of the question to edit

  EditQuestionScreen({required this.questionId});

  @override
  _EditQuestionScreenState createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
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

  @override
  void initState() {
    super.initState();
    fetchQuestion(); // Fetch existing question details
  }

  // Method to fetch existing question details using questionId
  Future<void> fetchQuestion() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch question data based on the questionId
      var question = await questionService.fetchQuestionById(widget.questionId);
      setState(() {
        questionTitle = question.questionTitle;
        option1 = question.option1;
        option2 = question.option2;
        option3 = question.option3;
        option4 = question.option4;
        rightAnswer = question.rightAnswer;
        category = question.category;
        difficultyLevel = question.difficultyLevel;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error (show message or log)
    }
  }

  // Method to update the question using the QuestionInputDto
  Future<String> updateQuestion(QuestionInputDto questionInputDto) async {
    return questionService.editQuestion(widget.questionId, questionInputDto);
  }

  // Submit form and handle question update
  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form input
      setState(() {
        isLoading = true; // Show loading spinner
      });

      // Create a QuestionInputDto object
      QuestionInputDto questionInputDto = QuestionInputDto(
        questionTitle: questionTitle,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        rightAnswer: rightAnswer,
        category: category,
        difficultyLevel: difficultyLevel,
      );

      try {
        await updateQuestion(questionInputDto); // Update question
        setState(() {
          isLoading = false; // Stop loading spinner
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Question updated successfully!')),
        );

        // Optionally, navigate back or reset the form
        Navigator.pop(context); // Go back to previous screen
      } catch (e) {
        setState(() {
          isLoading = false; // Stop loading spinner
        });

        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating question: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                initialValue: questionTitle,
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
                initialValue: option1,
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
                initialValue: option2,
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
                initialValue: option3,
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
                initialValue: option4,
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
                initialValue: rightAnswer,
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
                initialValue: category,
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
                initialValue: difficultyLevel,
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
                  child: Text('Update Question'),
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
    );
  }
}
