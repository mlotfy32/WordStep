import 'package:hive/hive.dart';
part 'saveMode.g.dart';

@HiveType(typeId: 4)
class SaveModel extends HiveObject {
  @HiveField(0)
  String courceName;
  @HiveField(1)
  String courceImage;
  SaveModel({required this.courceName, required this.courceImage});
}
