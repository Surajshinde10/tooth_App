import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tooth_app/utils/constant.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  final _numberController = TextEditingController();
  TextEditingController get numberController => _numberController;
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body:Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/json/4.json',
                  width: 400,
                  height: 400,
                  repeat: true,
                  fit: BoxFit.fill

                ),

                // Container(
                //   height: MediaQuery.of(context).size.height/2,
                //   width:  MediaQuery.of(context).size.width/0.7,
                //   decoration: BoxDecoration(color: Colors.white,
                //     border: Border.all(width: 0.5, color: secondary),boxShadow: [
                //       BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 1,offset: Offset(0, 1))
                //     ],
                //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                //   ),
                //   child: Image.asset(
                //     'assets/phone_back.png',fit: BoxFit.fitWidth,
                //
                //   ),
                // ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(color:kTitleTextColor,fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "We will send you a text message with a verification \n code that you'll need to enter on the next Screen !",
                  style: TextStyle(color: Colors.grey,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(

                  height: MediaQuery.of(context).size.height/15,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 06),
                        child: const Center(
                          child: Text(
                            "|",
                            style: TextStyle(fontSize: 33, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: TextField(
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.1,
                  height: MediaQuery.of(context).size.height/17,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {

                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber:
                          countryController.text + phone,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            MyPhone.verify = verificationId;
                            Navigator.pushNamed(context, 'verify');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        // Navigator.pushNamed(context, 'verify');
                      },
                      child: Text("Send the code",
                          style: GoogleFonts.notoSerif(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textStyle:  TextStyle(
                                color: Colors.white54,
                                letterSpacing: .5,
                              )))
                  ),
                )
              ],
            ),
          ),
        ],)


    );
  }
}
