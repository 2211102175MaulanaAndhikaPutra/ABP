import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.amber,
        ),
      ),
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    // Konfigurasi Android
    var androidInitSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    // Konfigurasi iOS
    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onSelectNotification(response.payload);
      },
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return NewScreen(payload: payload);
      }));
    }
  }

  Future<void> showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      'id', 'channel', 
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );

    var iosDetails = const DarwinNotificationDetails();

    var platformDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Flutter Devs',
      'Flutter Local Notification Demo',
      platformDetails,
      payload: 'Welcome to the Local Notification demo',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showNotification,
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  final String payload;

  const NewScreen({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}

