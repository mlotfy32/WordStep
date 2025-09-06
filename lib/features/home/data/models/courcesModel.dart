class CourcesModel {
  final String videoId;
  final String publishedAt;
  final String title;
  final String channelTitle;
  final String channelLogo;
  CourcesModel({
    required this.videoId,
    required this.publishedAt,
    required this.title,
    required this.channelTitle,
    required this.channelLogo,
  });
  factory CourcesModel.fromJson(data) {
    return CourcesModel(
      videoId: data['id']['videoId'],
      publishedAt: data['snippet']['publishedAt'],
      title: data['snippet']['title'],
      channelTitle: data['snippet']['channelTitle'],
      channelLogo: data['snippet']['thumbnails']['default']['url'],
    );
  }
}
