// models/question_output_dto.dart
class QuestionOutputDto {
  final int id;
  final String questionTitle;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  QuestionOutputDto({
    required this.id,
    required this.questionTitle,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  factory QuestionOutputDto.fromJson(Map<String, dynamic> json) {
    return QuestionOutputDto(
      id: json['id'],
      questionTitle: json['questionTitle'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      option4: json['option4'],
    );
  }
}
