// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:my_tooth_app/dashboard/dashBoardMainPage.dart';
// import 'package:my_tooth_app/utils/constant.dart';
// import 'package:pinput/pinput.dart';
// import 'auth_number.dart';
//
// class MyVerify extends StatefulWidget {
//   const MyVerify({Key? key}) : super(key: key);
//
//   @override
//   State<MyVerify> createState() => _MyVerifyState();
// }
//
// class _MyVerifyState extends State<MyVerify> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );
//
//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: const Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );
//
//     var code = "";
//
//     return Scaffold(
//       backgroundColor: kScaffoldBackground,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height/2.1,
//               width:  MediaQuery.of(context).size.width/0.6,
//               decoration: BoxDecoration(color: kScaffoldBackground,
//                 border: Border.all(width: 0.5, color: Colors.blue.shade400),boxShadow: [
//                   BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 1,offset: Offset(0, 1))
//                 ],
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(30)),
//               ),
//               child: Image.asset(
//                 'assets/otp_page.png',
//                 // width: 400,
//                 // height: 400,
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             const Text(
//               "Phone Verification",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "We need to register your phone without getting started!",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Pinput(
//               length: 6,
//               showCursor: true,
//               onChanged: (value) {
//                 code = value;
//               },
//               onCompleted: (pin) => const BottomNavDemo(),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width/1.2,
//               height: 45,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade600,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10))),
//                   onPressed: () async {
//                     try {
//                       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                           verificationId: MyPhone.verify, smsCode: code);
//
//
//                       await auth.signInWithCredential(credential);
//                       Navigator.pushNamedAndRemoveUntil(
//                           context, "profileDetails", (route) => false);
//                     } catch (e) {
//                       print("Wrong Otp");
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text('You Have Enter Wrong OTP !!')));
//                     }
//                   },
//                   child: const Text("Verify Phone Number")),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         'phone',
//                             (route) => false,
//                       );
//                     },
//                     child: Text(
//                       "Edit Phone Number ?",
//                       style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tooth_app/dashboard/dashBoardMainPage.dart';
import 'package:my_tooth_app/utils/constant.dart';
import 'package:pinput/pinput.dart';
import 'auth_number.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Scaffold(
      backgroundColor: kScaffoldBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/otp_back.png',fit: BoxFit.fitHeight,
              width: 400,
              height: 400,
            ),
            // Lottie.asset(
            //     'assets/json/5.json',
            //     width: 400,
            //     height: 400,
            //     repeat: true,
            //     fit: BoxFit.fill
            //
            // ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Phone Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "We need to register your phone without getting started!",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
              onCompleted: (pin) => const BottomNaviPage(),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              // width: MediaQuery.of(context).size.width/1.2,
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                          verificationId: MyPhone.verify, smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamedAndRemoveUntil(
                          context, "profileDetails", (route) => false);
                    } catch (e) {
                      print("Wrong Otp");
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('You Have Enter Wrong OTP !!')));
                    }
                  },
                  child: const Text("Verify Phone Number")),
            ),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'phone',
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
