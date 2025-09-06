class CourceLangModel {
  final String word;
  final String translation;
  final String example;
  final String image;

  CourceLangModel({
    required this.word,
    required this.translation,
    required this.example,
    required this.image,
  });
  factory CourceLangModel.fromJson(data) {
    return CourceLangModel(
      word: data['word'],
      translation: data['translation'],
      example: data['example'],
      image: data['image'],
    );
  }
}
