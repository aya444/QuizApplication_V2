// models/question_output_dto.dart
class QuestionInputDto {
  int? id;
  final String questionTitle;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String rightAnswer;
  final String category;
  final String difficultyLevel;

  QuestionInputDto({
    this.id,
    required this.questionTitle,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.rightAnswer,
    required this.category,
    required this.difficultyLevel
  });

  factory QuestionInputDto.fromJson(Map<String, dynamic> json) {
    return QuestionInputDto(
      id: json['id'],
      questionTitle: json['questionTitle'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      option4: json['option4'],
      rightAnswer: json['rightAnswer'],
      category: json['category'],
      difficultyLevel: json['difficultyLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionTitle': questionTitle,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'rightAnswer': rightAnswer,
      'category': category,
      'difficultyLevel': difficultyLevel,
    };
  }

}
