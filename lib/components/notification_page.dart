import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_tooth_app/utils/constant.dart';

class NotificationsReceivedPage extends StatefulWidget {

  @override
  _NotificationsReceivedPageState createState() =>
      _NotificationsReceivedPageState();
}

class _NotificationsReceivedPageState extends State<NotificationsReceivedPage> {
  Future<void> scheduleNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      // 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID (can be any unique integer)
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
    );
  }




  @override
  void initState() {
    super.initState();
    scheduleNotification(); // Schedule a notification when the page is displayed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: kDoctorCard1, // Set the background color
        title: Text(
          'Notifications',
          style: TextStyle(
            color: primary, // Set the text color
          ),
        ),
        iconTheme: IconThemeData(
          color: primary, // Set the back button color
        ),
      ),

        body: Center(
        child: Text('No Notification Available'),
      ),
    );
  }


}
