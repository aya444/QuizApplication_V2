class QuizInputDto {
  final String category;
  final int numOfQuestions;
  final String title;

  QuizInputDto({
    required this.category,
    required this.numOfQuestions,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'numOfQuestions': numOfQuestions,
        'title': title,
      };
}
