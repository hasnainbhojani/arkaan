import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 1)
class NotificationModel {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? body;

  @HiveField(2)
  final DateTime timestamp;

  NotificationModel({
    this.title,
    this.body,
    required this.timestamp,
  });
}
