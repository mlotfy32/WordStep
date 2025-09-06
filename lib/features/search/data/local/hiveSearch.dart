import 'package:hive/hive.dart';
part 'hiveSearch.g.dart';

@HiveType(typeId: 2)
class SearchModel extends HiveObject {
  @HiveField(0)
  String courceName;
  @HiveField(1)
  String imageUrl;

  SearchModel({required this.imageUrl, required this.courceName});
}
