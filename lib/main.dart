import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_tooth_app/dashboard/dashBoardMainPage.dart';
import 'package:my_tooth_app/dashboard/main_dashboard_screen.dart';
import 'package:my_tooth_app/utils/provider/provider.dart';
import 'OnboardingScreens/auth_number.dart';
import 'OnboardingScreens/auth_otp.dart';
import 'OnboardingScreens/splashcreen.dart';
import 'OnboardingScreens/user_info_screen.dart';
import 'setting_page/setting&ProfilePage.dart';
import 'firebase/firebase_options.dart';
import 'map_data/geolocator.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///notification///
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final InitializationSettings initializationSettings =
  InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'), // Replace with your app's launcher icon
    // iOS: IOSInitializationSettings(),
  );


  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // onSelectNotification: (String? payload) async {
    //   // Handle notification tap here
    // },
  );

  runApp(const MyAp());
}




class MyAp extends StatelessWidget {
  const MyAp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderApp(
      child: MaterialApp(
        initialRoute: 'splash',
        debugShowCheckedModeBanner: false,
        routes: {
          'splash': (context) =>  BottomNaviPage(),
          // 'splash': (context) =>  SplashScreen(),
          'home': (context) => BottomNaviPage(),
          'phone': (context) => MyPhone(),
          'verify': (context) =>  MyVerify(),
          'profileDetails': (context) =>  ProfileDetails(),
          // 'home': (context) => HomeScreen()
        },
      ),
    );
  }
}
