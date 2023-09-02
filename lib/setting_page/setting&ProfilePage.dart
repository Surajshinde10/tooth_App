import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tooth_app/utils/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

import '../OnboardingScreens/auth_number.dart';

class SettingsPage extends StatefulWidget {

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> _saveCurrentAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_address', address);
  }

  void _loadAddressFromFirestore() async {
    try {
      // Fetch the user's address from Firestore (replace 'users' and 'address' with your Firestore collection and document path)
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection('users').doc('your_user_id').get();

      if (snapshot.exists) {
        setState(() {
          currentAddress = snapshot.data()?['address'] ?? "No Address Found";
        });

        // Save the current address to shared preferences
        _saveCurrentAddress(currentAddress);
      }
    } catch (e) {
      print('Error loading address: $e');
    }
  }

  Future<String?> _loadCurrentAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_address');
  }

  Future<void> _saveEditedLocation(String newLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('edited_location', newLocation);
  }

  Future<String?> _loadEditedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('edited_location');
  }


  String currentAddress = '';


  final String dummyPrivacyPolicyURL = 'https://www.freeprivacypolicy.com/live/00e7f3d6-0feb-4307-ad9a-36ce271f7f16';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _loadAddressFromFirestore();
  }

  void _editAddress(BuildContext context) async {
    String? editedLocation = await _loadEditedLocation();

    String? savedCurrentAddress = await _loadCurrentAddress();


    String newAddress = editedLocation ?? currentAddress; // Initialize with the edited location, if available

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'New Address'),
                onChanged: (value) {
                  newAddress = value; // Update newAddress when text changes
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  await _saveEditedLocation(newAddress); // Save the edited location to shared preferences
                  try {
                    // Save the new address to Firestore (replace 'users' and 'address' with your Firestore collection and field name)
                    await firestore
                        .collection('users')
                        .doc('your_user_id')
                        .set({'address': newAddress});

                    setState(() {
                      currentAddress = newAddress; // Update the current address
                    });

                    Navigator.of(context).pop(); // Close the dialog
                  } catch (e) {
                    print('Error saving address: $e');
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDoctorCard1,
        title: Center(child: const Text('Settings & Profile Details',style: TextStyle(color: Colors.black),)),
      ),
      body:
      ListView(
        children: [


          Card(
            child: ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _launchPrivacyPolicyURL();
              },

            ),
          ),
          const Divider(),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Change Location'),
              subtitle: Text(currentAddress),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _loadAddressFromFirestore();
                _editAddress(context);
              },
            ),
          ),
          const Divider(),
          const Card(
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Icon(Icons.arrow_forward),
              // onTap: () {
              //   // Add notification settings here
              // },
            ),
          ),
          const Divider(),
          const Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              trailing: Icon(Icons.arrow_forward),
              // onTap: () {
              //   // Add security settings here
              // },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              decoration: BoxDecoration( color: Colors.green.shade600,

              ),
              height: MediaQuery.of(context).size.height/18,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green.shade600,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const MyPhone() ));            },
                child: Text('Log Out',style: TextStyle(color: Colors.white54,fontSize: 16),),
              ),
            ),
          )
        ],
      ),
    );
  }
}



Future<void> _launchPrivacyPolicyURL() async {

  final String dummyPrivacyPolicyURL = 'https://www.freeprivacypolicy.com/live/00e7f3d6-0feb-4307-ad9a-36ce271f7f16';

  final String url = dummyPrivacyPolicyURL;

  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error: $e');
  }
}


