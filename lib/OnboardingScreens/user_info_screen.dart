import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tooth_app/controller/home_controller.dart';
import 'package:my_tooth_app/dashboard/dashBoardMainPage.dart';
import 'package:provider/provider.dart';

import '../utils/constant.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, _) => Scaffold(
        backgroundColor: kScaffoldBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                // Image.asset(
                //   'assets/img1.png',
                //   width: 400,
                //   height: 400,
                // ),
                Lottie.asset(
                    'assets/json/2.json',
                    width: 400,
                    height: 400,
                    repeat: true,
                    fit: BoxFit.fill

                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Profile Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height/18,
                  width: MediaQuery.of(context).size.width/1.2,

                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black, spreadRadius: 0.3),
                    ],),
                  child: TextField(
                    controller: value.nameController,
                    decoration: const InputDecoration(contentPadding: EdgeInsets.only(top: 13), // add padding to adjust text
                      isDense: true,
                        border: InputBorder.none,
                      // label: Center(child: Text("Name",style: TextStyle(),)),

                      hintText:"Name",

                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),



                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 9), // add padding to adjust icon
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Icon(Icons.person_2_outlined,size: 30,color:Colors.grey,),
                        ),
                     )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                // Container(
                //   height: MediaQuery.of(context).size.height/18,
                //   decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
                //     color: Colors.white,
                //     boxShadow: const [
                //       BoxShadow(color: Colors.black, spreadRadius: 1),
                //     ],),
                //   child: Center(
                //     child: TextField(
                //       controller: value.mobileController,
                //       decoration: const InputDecoration(contentPadding: EdgeInsets.only(top: 20), // add padding to adjust text
                //           isDense: true,
                //           hintText: "Phone",
                //           prefixIcon: Padding(
                //             padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                //             child: Icon(Icons.phone),
                //           )
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 18,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        // Check if the text exceeds the character limit (e.g., 50 characters)
                        if (value.nameController.text.length > 1) {
                          FlutterSecureStorage prefs = const FlutterSecureStorage();
                          await prefs.write(
                            key: 'name',
                            value: value.nameController.text,
                          );

                          CollectionReference collRef =
                          FirebaseFirestore.instance.collection("user");
                          collRef.add({
                            'name': value.nameController.text,
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNaviPage(),
                            ),
                          );
                        }


                      } catch (e) {



                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                )






              ],
            ),
          ),
        ),
      ),
    );
  }
}
