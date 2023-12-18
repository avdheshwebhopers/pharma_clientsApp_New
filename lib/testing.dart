import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.data}');
      _showNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.data}');
      _handleNotificationClick(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      Map<String, dynamic> notificationData = jsonDecode(payload);
      _handleNotificationClick(notificationData);
    }
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    print('Background message: ${message.data}');
    _showNotification(message.data);
  }

  Future<void> _showNotification(Map<String, dynamic> notificationData) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.show(
      0,
      notificationData['title'] ?? 'Default Title',
      notificationData['message'] ?? 'Default Message',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        ),
        iOS: const DarwinNotificationDetails(
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(notificationData),
    );
  }

  void _handleNotificationClick(Map<String, dynamic> notificationData) {
    print('Notification clicked: $notificationData');
    // Add your logic for handling the notification click
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _firebaseMessaging.subscribeToTopic('exampleTopic');
            _firebaseMessaging.getToken().then((token) {
              print('FCM Token: $token');
            });

            _firebaseMessaging.subscribeToTopic('exampleTopic');
            _firebaseMessaging.getToken().then((token) {
              print('FCM Token: $token');
            });

            _firebaseMessaging.subscribeToTopic('exampleTopic');
            _firebaseMessaging.getToken().then((token) {
              print('FCM Token: $token');
            });

            // Simulate receiving a notification
            Map<String, dynamic> notificationData = {
              'title': 'Hi',
              'message': 'Test',
            };
            _showNotification(notificationData);
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
