class QuizOutputDto {
  final int id;
  final String title;

  QuizOutputDto({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };

  factory QuizOutputDto.fromJson(Map<String, dynamic> json) {
    return QuizOutputDto(
      id: json['id'],
      title: json['title'],
    );
  }
}
