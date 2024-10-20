import 'package:flutter/material.dart';
import 'package:quiz_application/services/QuizService.dart';
import '../models/QuizInputDto.dart'; // Import the model

class CreateQuizScreen extends StatefulWidget {
  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  QuizService quizService = QuizService();

  String category = '';
  int numOfQuestions = 0;
  String title = '';
  bool isLoading = false; // To manage loading state

  // Method to create the quiz using the QuizInputDto
  Future<int> createQuiz(QuizInputDto quizInputDto) async {
    return quizService.createQuiz(quizInputDto);
  }

  // Submit form and handle quiz creation
  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form input
      setState(() {
        isLoading = true; // Show loading spinner
      });

      // Create a QuizInputDto object
      QuizInputDto quizInputDto = QuizInputDto(
          category: category, numOfQuestions: numOfQuestions, title: title);

      try {
        int? quizId = await createQuiz(quizInputDto); // Allow quizId to be null
        setState(() {
          isLoading = false; // Stop loading spinner
        });

        if (quizId != null) {
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Quiz created successfully with ID: $quizId')),
          );

          // Reset the form fields to clear the input data
          _formKey.currentState!.reset();
          setState(() {
            category = '';
            numOfQuestions = 0;
            title = '';
          });
        } else {
          // Handle case where quizId is null
          throw Exception("Quiz creation returned null ID.");
        }

      } catch (e) {
        setState(() {
          isLoading = false; // Stop loading spinner
        });

        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating quiz: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
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
              SizedBox(height: 50),
              Text(
                "Please enter the quiz data",
                style: TextStyle(color: Colors.white, fontSize: 23),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Quiz Category',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70), // White border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple.withOpacity(0.7), // Illuminating purple when focused
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
                  labelText: 'Number of Questions',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70), // White border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple.withOpacity(0.7), // Illuminating purple when focused
                      width: 2.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of questions';
                  }
                  // Validate that the value is a valid integer
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    numOfQuestions = int.parse(value); // Correctly parse the value to an int
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Quiz Title',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70), // White border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple.withOpacity(0.7), // Illuminating purple when focused
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quiz title';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    title = value; // Handle the value safely
                  }
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: Text('Create Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Button color
                    fixedSize: Size(160, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 17, color: Colors.purple, fontWeight: FontWeight.bold),
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
