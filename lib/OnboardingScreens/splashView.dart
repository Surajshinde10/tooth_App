
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_tooth_app/OnboardingScreens/auth_number.dart';
import '../dashboard/dashBoardMainPage.dart';
import '../dashboard/main_dashboard_screen.dart';


class SplashServices {
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser ;

    if(user != null){
      // Timer(const Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomNavDemo()))
      Timer(const Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNaviPage()))

    );
    }else{
      Timer(const Duration(seconds: 5), ()=> Navigator.push(context, MaterialPageRoute(builder:(context) => const MyPhone() )));
    }
  }
}


