// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class BaseService {
//   Future<void> verifyPhoneNumber(
//       BuildContext context, String countryCode, String numebr) async {
//     try {
//       String phoneNumber = '+$countryCode$numebr';
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {
//           // Handle verification failure
//           print('Verification Failed: ${e.message}');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Navigator.pushNamed(context, 'verify', arguments: verificationId);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
