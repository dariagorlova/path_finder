class SendResult {
  final String id;
  final bool correct;
  SendResult({required this.id, required this.correct});

  factory SendResult.fromJson(Map<String, dynamic> json) {
    return SendResult(
      id: json['id'],
      correct: json['correct'],
    );
  }
}
