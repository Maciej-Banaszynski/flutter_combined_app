import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationProvider() {
    _configureFCM();
    _initializeLocalNotifications();
    _requestNotificationPermissions();
    _setupFCMTokenListener();
  }

  void _configureFCM() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotificationWithActions(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked with data: ${message.data}");
    });
  }

  void _requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted notification permissions.");
    } else {
      print("User denied notification permissions.");
    }
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    if (message.notification != null) {
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(iOS: DarwinInitializationSettings()),
      );

      final notificationProvider = NotificationProvider();
      notificationProvider._showNotificationWithActions(message);
    }
  }

  void _initializeLocalNotifications() {
    const iosInitSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(iOS: iosInitSettings);

    _flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void _setupFCMTokenListener() {
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print("FCM Token refreshed: $newToken");
    });
  }

  Future<void> _showNotificationWithActions(RemoteMessage message) async {
    const iosDetails = DarwinNotificationDetails();
    const platformDetails = NotificationDetails(iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload: 'some_payload',
    );
  }
}

class NotificationManager extends HookWidget {
  const NotificationManager({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = useMemoized(() => NotificationProvider(), []);
    useEffect(() {
      notificationProvider._configureFCM();
      FirebaseMessaging.onBackgroundMessage(NotificationProvider._backgroundMessageHandler);
      return null;
    }, [notificationProvider]);

    return const SizedBox.shrink();
  }
}
