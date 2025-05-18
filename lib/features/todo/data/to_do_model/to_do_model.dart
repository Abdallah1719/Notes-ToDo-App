import 'package:hive/hive.dart';

part 'to_do_model.g.dart';

@HiveType(typeId: 1)
class ToDoModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final String date;
  @HiveField(3)
  String status;

  ToDoModel(
      {required this.title,
      required this.time,
      required this.date,
      required this.status});
}
