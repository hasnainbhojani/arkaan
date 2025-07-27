import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/notification_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<NotificationModel>('notifications');

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<NotificationModel> box, _) {
          final notifications = box.values.toList().reversed.toList();
          if (notifications.isEmpty) {
            return Center(child: Text('No notifications yet'));
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, i) {
              final n = notifications[i];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.white30,
                  title: Text(n.title ?? '<no title>'),
                  subtitle: Text(n.body ?? ''),
                  trailing: Text(
                    TimeOfDay.fromDateTime(n.timestamp).format(context),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
