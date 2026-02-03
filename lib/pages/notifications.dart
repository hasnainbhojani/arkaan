import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/notification_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Box<NotificationModel> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<NotificationModel>('notifications');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          // 🔄 Refresh
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),

          // 🗑 Clear All
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              if (box.isEmpty) return;

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text(
                    'Clear all notifications?',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'This action cannot be undone.',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        box.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<NotificationModel> box, _) {
          final notifications = box.values.toList().reversed.toList();

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                'No notifications yet',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, i) {
              final n = notifications[i];

              return Dismissible(
                key: ValueKey(n.timestamp.toIso8601String()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  final key = box.keyAt(box.length - 1 - i);
                  box.delete(key);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: Colors.white30,
                    title: Text(
                      n.title ?? '<no title>',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (n.body != null && n.body!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(n.body!),
                          ),
                        const SizedBox(height: 6),
                        Text(
                          _formatDateTime(context, n.timestamp),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // 📅 Correct Date & Time Formatter
  String _formatDateTime(BuildContext context, DateTime dateTime) {
    final date = "${dateTime.day.toString().padLeft(2, '0')}-"
        "${dateTime.month.toString().padLeft(2, '0')}-"
        "${dateTime.year}";
    final time = TimeOfDay.fromDateTime(dateTime).format(context);
    return "$date • $time";
  }
}

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../models/notification_model.dart';

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box<NotificationModel>('notifications');

//     return Scaffold(
//       appBar: AppBar(title: Text('Notifications')),
//       body: ValueListenableBuilder(
//         valueListenable: box.listenable(),
//         builder: (context, Box<NotificationModel> box, _) {
//           final notifications = box.values.toList().reversed.toList();
//           if (notifications.isEmpty) {
//             return Center(child: Text('No notifications yet'));
//           }
//           return ListView.builder(
//             itemCount: notifications.length,
//             itemBuilder: (context, i) {
//               final n = notifications[i];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   tileColor: Colors.white30,
//                   title: Text(n.title ?? '<no title>'),
//                   subtitle: Text(n.body ?? ''),
//                   trailing: Text(
//                     TimeOfDay.fromDateTime(n.timestamp).format(context),
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
