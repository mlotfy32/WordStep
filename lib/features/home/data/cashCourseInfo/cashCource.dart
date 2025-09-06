import 'package:hive/hive.dart';
part 'cashCource.g.dart';

@HiveType(typeId: 3)
class CashCource extends HiveObject {
  @HiveField(0)
  String courceName;
  @HiveField(1)
  String watcheHoures;
  @HiveField(2)
  DateTime startedCourceAt;
  @HiveField(3)
  int achievement;
  CashCource({
    required this.courceName,
    required this.watcheHoures,
    required this.startedCourceAt,
    required this.achievement,
  });
}
