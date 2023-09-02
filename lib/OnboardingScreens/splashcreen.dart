import 'package:flutter/material.dart';
import 'package:my_tooth_app/OnboardingScreens/splashView.dart';
import 'package:my_tooth_app/utils/constant.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width/3,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/final_logo.png"))),
          ),),
          // Text("My Tooth",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: kOrangeColor),),


        ],
      )


    );
  }
}

// class splashscreen extends StatelessWidget {
//   // ithe tu function vaigre kay asel tey taktes
//   const splashscreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( // app mdhe fkt 3 main widget astat appbar body ani bottom nevigation thamb tula dakhvto
//       appBar: AppBar(
//
//       ),
//       body: ,
//     );// me tula code karun dakhvto
//   }
// }

