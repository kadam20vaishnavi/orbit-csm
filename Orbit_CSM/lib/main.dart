import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbit_csm/firebase_options.dart';
import 'package:orbit_csm/ui/Splash/SplashScreeen.dart';
import 'package:orbit_csm/util/preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Ensure Firebase is initialized
  await PushNotificationService().initialize();
  await Preference.init(); // Initialize SharedPreferences

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orbit CSM',
      theme: ThemeData(
        fontFamily: 'Lato',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission (for iOS)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _fcm.setAutoInitEnabled(true);
    String? token = await FirebaseMessaging.instance.getToken();
    print("token:$token");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');
    } else {
      print('User denied or has not granted notification permissions');
    }

    // Foreground notification handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message in the foreground: ${message.messageId}');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Notification title: ${message.notification?.title}');
        print('Notification body: ${message.notification?.body}');
      }
    });

    // Background and terminated notification handling
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked! ${message.data}");
    });

    // Get the initial message if the app was opened from a notification
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      print("App opened from terminated state: ${initialMessage.messageId}");
    }
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('FCM Token: $token');
    return token;
  }
}
