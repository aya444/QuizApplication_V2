class Response {
  final int id;
  final String response;

  Response({
    required this.id,
    required this.response,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'response': response,
  };
}
