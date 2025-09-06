class QuizeModel {
  final String question;
  final List<dynamic> options;
  final String answer;

  QuizeModel({
    required this.question,
    required this.options,
    required this.answer,
  });
  factory QuizeModel.fromJson(data) {
    return QuizeModel(
      question: data['question'],
      options: data['options'],
      answer: data['answer'],
    );
  }
}
