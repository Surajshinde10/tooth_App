import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tooth_app/controller/home_controller.dart';
import 'package:my_tooth_app/dashboard/doctor_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../OnboardingScreens/auth_number.dart';
import '../components/notification_page.dart';
import '../model/doctorData.dart';
import '../utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../utils/constant.dart';
import 'myAppointmentPage.dart';

class MainDashboard extends StatefulWidget {
  MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  File?   _profilePhoto;

  Future<void> _pickProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Save the image to a local directory
      final appDir = await getApplicationDocumentsDirectory();
      final profileImageFile = File(join(appDir.path, 'profile_image.png'));
      await imageFile.copy(profileImageFile.path);

      // Store the image path in shared preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('profileImagePath', profileImageFile.path);

      setState(() {
        _profilePhoto = profileImageFile;
      });
    }
  }
  //////shared prefrences ///////
  void saveSelectedPlaceAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPlaceAddress', address);
  }

  void saveBoolToPrefs(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  // saveBoolToPrefs('isUserLoggedIn', true);
  void updateSelectedPlace(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('selectedPlaceLatitude', latitude);
    await prefs.setDouble('selectedPlaceLongitude', longitude);

    setState(() {
      selectedPlaceLatitude = latitude;
      selectedPlaceLongitude = longitude;
    });
  }

  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      double savedLatitude = prefs.getDouble('selectedPlaceLatitude') ?? 0.0;
      double savedLongitude = prefs.getDouble('selectedPlaceLongitude') ?? 0.0;
      String savedAddress = prefs.getString('selectedPlaceAddress') ?? '';

      final imagePath = prefs.getString('profileImagePath');

      if(imagePath != null) {
        setState(() {

          _profilePhoto = File(imagePath);

          selectedPlaceLatitude = savedLatitude;
          selectedPlaceLongitude = savedLongitude;
          selectedPlaceAddress = savedAddress;
        });
      }

    });
    _controller.addListener(() {
      onChange();
    });

    // Retrieve stored latitude and longitude
    SharedPreferences.getInstance().then((prefs) {
      double savedLatitude = prefs.getDouble('selectedPlaceLatitude') ?? 0.0;
      double savedLongitude = prefs.getDouble('selectedPlaceLongitude') ?? 0.0;
      setState(() {
        selectedPlaceLatitude = savedLatitude;
        selectedPlaceLongitude = savedLongitude;
      });
    });
  }

  Future<List<double>> fetchDistances(List<DoctorDetails> dataList) async {
    List<double> distances = [];

    for (var data in dataList) {
      double distance = await calculateDistance(
        selectedPlaceLatitude,
        selectedPlaceLongitude,
        data.latitude,
        data.longitude,
      );
      distances.add(distance);
    }

    return distances;
  }

  Future<double> calculateDistance(
      double userLat, double userLng, double docLat, double docLng) async {
    double distance =
    await Geolocator.distanceBetween(userLat, userLng, docLat, docLng);
    return distance / 1000; // Convert distance from meters to kilometers
  }

  double selectedPlaceLatitude = 0.0;
  double selectedPlaceLongitude = 0.0;

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList = [];



  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggesion(_controller.text);
  }


  void getSuggesion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDGiDTfpX3lDemEOcxvkPALFEK9Z-RnjPs";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var predictions = jsonDecode(response.body.toString())['predictions'];
      List<dynamic> updatedPlacesList = [];

      for (var prediction in predictions) {
        String placeId = prediction['place_id'];
        Map<String, dynamic> details = await getPlaceDetails(placeId);

        if (details != null) {
          double latitude = details['geometry']['location']['lat'];
          double longitude = details['geometry']['location']['lng'];
          updatedPlacesList.add({
            'description': prediction['description'],
            'latitude': latitude,
            'longitude': longitude,
          });
          updateSelectedPlace(latitude, longitude);
        }
      }

      setState(() {
        _placesList = updatedPlacesList;
      });
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future getPlaceDetails(String placeId) async {
    String kPLACES_API_KEY = "AIzaSyDGiDTfpX3lDemEOcxvkPALFEK9Z-RnjPs";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?place_id=$placeId&key=$kPLACES_API_KEY';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body.toString())['result'];
      return result;
    } else {
      return Container();
    }
  }
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

  Set<int> addedCardIndices = Set<int>();

  String currentAddress = '';


  final String dummyPrivacyPolicyURL = 'https://www.freeprivacypolicy.com/live/00e7f3d6-0feb-4307-ad9a-36ce271f7f16';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadAddressFromFirestore();
  // }



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

  final String message =
  DateTime.now().hour < 12 ? "Good morning" : "Good afternoon";

  String selectedPlaceAddress = '';

  bool hasNearbyDentists = true;


  @override
  Widget build(BuildContext context) {
    context.read<HomeController>().fetchDoctorDetails();
    return Consumer<HomeController>(
      builder: (context, homePro, _) =>
          Scaffold(
            backgroundColor: kScaffoldBackground,
            drawer: Drawer(
              backgroundColor: kScaffoldBackground,
              child:
              ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                    onTap: _pickProfilePhoto,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make the container a circle
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: 3.0, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _profilePhoto != null ? FileImage(_profilePhoto!) : null,
                        child: _profilePhoto == null
                            ? ClipOval(
                          child: Image.asset('assets/Profile_picture.png'),
                        )
                            : null,
                      ),
                    ),
                  ),

                  Center(child: Text(homePro.nameController.text.toString(),style: TextStyle(fontSize: 25,color:Colors.black),)),

              SizedBox(height: 20,),
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
                  SizedBox(height: 200,),
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
              // ListView(
              //   // Important: Remove any padding from the ListView.
              //   padding: EdgeInsets.zero,
              //   children: <Widget>[
              //     UserAccountsDrawerHeader(
              //       accountName: Text("Abhishek Mishra"),
              //       accountEmail: Text("abhishekm977@gmail.com"),
              //       currentAccountPicture: CircleAvatar(
              //         backgroundColor: Colors.orange,
              //         child: Text(
              //           "A",
              //           style: TextStyle(fontSize: 40.0),
              //         ),
              //       ),
              //     ),
              //     ListTile(
              //       leading: Icon(Icons.home), title: Text("Home"),
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //     ListTile(
              //       leading: Icon(Icons.settings), title: Text("Settings"),
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //     ListTile(
              //       leading: Icon(Icons.contacts), title: Text("Contact Us"),
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //   ],
              // ),

    ),

            appBar: AppBar(

              // automaticallyImplyLeading: false,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              backgroundColor: kDoctorCard1,
              actions: [
                // Add an IconButton to open the drawer


                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('assets/final_logo.png'),
                ),
                SizedBox(width: 119),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationsReceivedPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.notification_add_rounded,
                    size: 35,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),

body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: <Widget>[
    //     // GestureDetector(
    //     //   onTap: _pickProfilePhoto,
    //     //   child: Container(
    //     //     height: 48,
    //     //     width: 48,
    //     //     decoration: BoxDecoration(
    //     //       shape: BoxShape.circle, // Make the container a circle
    //     //       border: Border.all(
    //     //         color: Colors.white, // Border color
    //     //         width: 3.0, // Border width
    //     //       ),
    //     //     ),
    //     //     child: CircleAvatar(
    //     //       radius: 50,
    //     //       backgroundImage: _profilePhoto != null ? FileImage(_profilePhoto!) : null,
    //     //       child: _profilePhoto == null
    //     //           ? ClipOval(
    //     //         child: Image.asset('assets/Profile_picture.png'),
    //     //       )
    //     //           : null,
    //     //     ),
    //     //   ),
    //     // ),
    //
    //     // GestureDetector(
    //     //   onTap: _pickProfilePhoto,
    //     //   child: Container(
    //     //     height: 48,
    //     //     width: 48,
    //     //     child:
    //     //     CircleAvatar(
    //     //       radius: 50,
    //     //       backgroundImage: _profilePhoto != null ? FileImage(_profilePhoto!) : null,
    //     //       child: _profilePhoto == null
    //     //           ? ClipRRect(
    //     //         borderRadius: BorderRadius.circular(100),
    //     //         child: Image.asset('assets/Profile_picture.png'),
    //     //       )
    //     //           : null,
    //     //     ),
    //     //   ),
    //     // ),
    //     // SizedBox(width: 110), // Add spacing between the avatars
    //     //
    //     // const    CircleAvatar(
    //     //   radius: 22,
    //     //   backgroundImage: AssetImage('assets/final_logo.png'),
    //     // ),
    //
    //     SizedBox(width: 119), // Add spacing between the logo and the icon
    //
    //     // GestureDetector(
    //     //   onTap: () {
    //     //     // Navigate to the "Notifications Received" page here
    //     //     Navigator.push(
    //     //       context,
    //     //       MaterialPageRoute(
    //     //         builder: (context) => NotificationsReceivedPage(), // Replace with the actual page you want to navigate to
    //     //       ),
    //     //     );
    //     //   },
    //     //   child: Icon(
    //     //     Icons.notification_add_rounded,
    //     //     size: 35,
    //     //     color: Colors.black54,
    //     //   ),
    //     // ),
    //
    //     // Icon(
    //     //   Icons.notification_add_rounded,
    //     //   size: 35,
    //     //   color: Colors.black54,
    //     //
    //     // ),
    //     SizedBox(width: 20,)
    //   ],
    // ),

    const SizedBox(
      height: 10,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Center(
        child: Text(
          'Find Your Desired Dentist',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 16,
            color: kTitleTextColor,
          ),
        ),
      ),
    ),

    Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 17,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.6, color: primary),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: selectedPlaceAddress,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.add_location_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ],
            )
          ],
        )),
    if (_placesList.isNotEmpty)
      Expanded(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: _placesList.length,
            itemBuilder: (context, index) {
              final suggestion = _placesList[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    suggestion['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    double latitude = suggestion['latitude'];
                    double longitude = suggestion['longitude'];
                    String address = suggestion['description'];

                    setState(() {
                      selectedPlaceLatitude = latitude;
                      selectedPlaceLongitude = longitude;
                      selectedPlaceAddress = address;
                      _placesList.clear();
                      _controller.clear();
                    });
                    saveSelectedPlaceAddress(address);
                  },
                ),
              );
            },
          ),
        ),
      ),


    SizedBox(
      height: 20,
    ),



    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Nearby Dentist',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: kTitleTextColor,
          fontSize: 18,
        ),
      ),
    ),
    const SizedBox(height: 10,),
    // Padding(
    //   padding: const EdgeInsets.only(left: 10, right: 10),
    //   child: Container(
    //     color: kSearchBackgroundColor,
    //     height: MediaQuery.of(context).size.height/3,
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           FutureBuilder<List<double>>(
    //
    //             future: fetchDistances(homePro.vanLIst),
    //             builder: (context, snapshot) {
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return CircularProgressIndicator();
    //               } else if (snapshot.hasError) {
    //                 return Text("Error: ${snapshot.error}");
    //               } else if (snapshot.hasData) {
    //                 List<double> distances = snapshot.data!;
    //                 List<Color> cardColors = [kDoctorCard1, kWhiteColor]; // Define your desired colors
    //
    //                 List<Widget> doctorCards = [];
    //
    //                 for (int index = 0; index < homePro.vanLIst.length; index++) {
    //                   final data = homePro.vanLIst[index];
    //                   double doctorDistance = distances[index];
    //
    //                   if (doctorDistance <= 10.0) {
    //                     int colorIndex = index % cardColors.length; // Use modulo to loop through the colors
    //                     Color cardColor = cardColors[colorIndex];
    //
    //                     doctorCards.add(
    //                       InkWell(
    //                         onTap: () {
    //                           Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                               builder: (context) => DetailScreen(data: data),
    //                             ),
    //                           );
    //                         },
    //                         child: DoctorCard(
    //                           data.name,
    //                           '${data.qualification} - ${data.clinicName}',
    //                           data.profilePic,
    //                           cardColor,
    //                         ),
    //                       ),
    //                     );
    //                   }
    //                 }
    //
    //                 if (doctorCards.isEmpty) {
    //                   hasNearbyDentists = false;
    //                   doctorCards.add(
    //                       Column(children: [
    //                         Stack(
    //
    //                           children: [
    //                             // Icon(
    //                             //   Icons.cancel_outlined,
    //                             //   size: 35,
    //                             //   color: Colors.black54,
    //                             // ),
    //
    //                             Lottie.asset(
    //                                 'assets/json/3.json',
    //                                 width: 400,
    //                                 height: 400,
    //                                 repeat: true,
    //                                 fit: BoxFit.fill
    //
    //                             ),
    //
    //                             // Padding(
    //                             //   padding: const EdgeInsets.only(bottom: 50),
    //                             //   child: Center(
    //                             //     child: Image.asset(
    //                             //       'assets/otp_screen.png',
    //                             //       width: 400,
    //                             //       height: 400,
    //                             //       fit: BoxFit.fitHeight,
    //                             //     ),
    //                             //   ),
    //                             // ),
    //
    //                             Padding(
    //                               padding: const EdgeInsets.only(top: 420),
    //                               child: Center(
    //                                 child: Text("   Please Select Address    \nWhere Dentist Available !!",
    //                                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: kTitleTextColor),),
    //                               ),
    //                             ),
    //                             // Padding(
    //                             //   padding: const EdgeInsets.only(right: 100),
    //                             //   child: Icon(
    //                             //     Icons.cancel_outlined,
    //                             //     size: 100,
    //                             //     color: Colors.black54,
    //                             //   ),
    //                             // ),
    //                           ],
    //                         )
    //
    //                       ],)
    //
    //                   );
    //                 } else {
    //                   hasNearbyDentists = true;
    //                 }
    //
    //                 return Column(
    //                   children: doctorCards,
    //                 );
    //               }
    //               return Center(
    //                 child: Text("No More Doctors Available"),
    //               );
    //             },
    //           )
    //
    //           // FutureBuilder<List<double>>(
    //           //   future: fetchDistances(homePro.vanLIst),
    //           //   builder: (context, snapshot) {
    //           //     if (snapshot.connectionState == ConnectionState.waiting) {
    //           //       return CircularProgressIndicator();
    //           //     } else if (snapshot.hasError) {
    //           //       return Text("Error: ${snapshot.error}");
    //           //     } else if (snapshot.hasData) {
    //           //       List<double> distances = snapshot.data!;
    //           //       List<Color> cardColors = [kDoctorCard1, kWhiteColor, ]; // Define your desired colors
    //           //
    //           //       return ListView.builder(
    //           //         physics: const BouncingScrollPhysics(),
    //           //         shrinkWrap: true,
    //           //         itemCount: homePro.vanLIst.length,
    //           //         itemBuilder: (context, index) {
    //           //           final data = homePro.vanLIst[index];
    //           //           double doctorDistance = distances[index];
    //           //
    //           //           if (doctorDistance <= 10.0) {
    //           //             int colorIndex = index % cardColors.length; // Use modulo to loop through the colors
    //           //             Color cardColor = cardColors[colorIndex];
    //           //
    //           //             return InkWell(
    //           //               onTap: () {
    //           //                 Navigator.push(
    //           //                   context,
    //           //                   MaterialPageRoute(
    //           //                     builder: (context) => DetailScreen(
    //           //                       data: data,
    //           //                     ),
    //           //                   ),
    //           //                 );
    //           //               },
    //           //               child: DoctorCard(
    //           //                 data.name,
    //           //                 '${data.qualification} - ${data.clinicName}',
    //           //                 data.profilePic,
    //           //                 cardColor,
    //           //               ),
    //           //             );
    //           //           }
    //           //           return Container();
    //           //         },
    //           //       );
    //           //     }
    //           //     return Center(
    //           //       child: Container(
    //           //         child: Text("No More Doctors Available"),
    //           //       ),
    //           //     );
    //           //   },
    //           // )
    //         ],
    //       ),
    //     ),
    //   ),
    // ),



    // Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 10, right: 10),
    //     child: Container(
    //       // height: MediaQuery.of(context).size.height/2,
    //       // width: MediaQuery.of(context).size.width/0.5,
    //       // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),boxShadow: [
    //       //   BoxShadow(color: kSearchBackgroundColor, spreadRadius: 3,),
    //       // ],),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             FutureBuilder<List<double>>(
    //               future: fetchDistances(homePro.vanLIst),
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState ==
    //                     ConnectionState.waiting) {
    //                   return CircularProgressIndicator(); // Show loading indicator
    //                 } else if (snapshot.hasError) {
    //                   return Text("Error: ${snapshot.error}");
    //                 } else if (snapshot.hasData) {
    //                   List<double> distances = snapshot.data!;
    //                   return ListView.builder(
    //                     physics: const BouncingScrollPhysics(),
    //                     shrinkWrap: true,
    //                     itemCount: homePro.vanLIst.length,
    //                     itemBuilder: (context, index) {
    //                       final data = homePro.vanLIst[index];
    //                       double doctorDistance = distances[index];
    //
    //                       if (doctorDistance <= 10.0) {
    //                         return InkWell(
    //                           onTap: () {
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     DetailScreen(
    //                                   data: data,
    //                                 ),
    //                               ),
    //                             );
    //                           },
    //                           child: DoctorCard(
    //                             data.name,
    //                             '${data.qualification} - ${data.clinicName}',
    //                             data.profilePic,
    //                             Color(int.parse(data.cardColor)),
    //                           ),
    //                         );
    //                       }
    //                       return Container(); // Return an empty container for distances > 10.0
    //                     },
    //                   );
    //                 }
    //                 return Center(
    //                     child: Container(
    //                   child: Text("No More Doctors Available"),
    //                 )); // Fallback, return an empty container
    //               },
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // )

    // buildDoctorList(),
    Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        color: kSearchBackgroundColor,
        height: MediaQuery.of(context).size.height / 7,
        child: SingleChildScrollView(
          child:
          FutureBuilder<List<double>>(
            future: fetchDistances(homePro.vanLIst),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                List<double> distances = snapshot.data!;
                List<Color> cardColors = [kDoctorCard1, kWhiteColor]; // Define your desired colors

                List<Widget> doctorCards = [];

                for (int index = 0; index < homePro.vanLIst.length; index++) {
                  final data = homePro.vanLIst[index];
                  double doctorDistance = distances[index];

                  if (doctorDistance <= 10.0) { // Adjust the radius as needed
                    int colorIndex = index % cardColors.length; // Use modulo to loop through the colors
                    Color cardColor = cardColors[colorIndex];

                    doctorCards.add(
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(data: data),
                            ),
                          );
                        },
                        child: DoctorCard(
                          data.name,
                          '${data.qualification} - ${data.clinicName}',
                          data.profilePic,
                          cardColor,
                        ),
                      ),
                    );
                  }
                }

                if (doctorCards.isEmpty) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Lottie.asset(
                            'assets/json/3.json',
                            width: 400,
                            height: 400,
                            repeat: true,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 420),
                            child: Center(
                              child: Text(
                                "Please Select Address\nWhere Dentist Available !!",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kTitleTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                // Use CarouselSlider here
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 110, // Adjust the height as needed
                    aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                    viewportFraction: 0.8, // Set the fraction of the viewport to display
                    initialPage: 0, // Index of the initial item
                    enableInfiniteScroll: false, // Enable infinite scrolling
                    reverse: false, // Reverse the order of cards
                    autoPlay: true, // Auto-play the carousel
                    autoPlayInterval: Duration(seconds: 5), // Auto-play interval
                    autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
                    autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
                    enlargeCenterPage: true, // Enlarge the center card
                    onPageChanged: (index, reason) {
                      // Callback when the page changes
                    },
                  ),
                  items: doctorCards,
                );
              }

              return Center(
                child: Text("No More Doctors Available"),
              );
            },
          )

        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          // Navigate to the AppointmentScreen when the container is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointmentScreen()),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 15,
          width: MediaQuery.of(context).size.width / 1,
          decoration: BoxDecoration(
            color: kSearchTextColor,
            borderRadius: BorderRadius.circular(10.0), // Border radius
          ),
          child: Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.calendar_month),
              SizedBox(width: 50,),
              Text("My Appointment",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
            ],
          ),
        ),
      ),
    )

  ],
),
          ),
    );
  }

  loadData() {}

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }
}



class DoctorCard extends StatelessWidget {
  final _name;
  final _description;
  final _imageUrl;
  final _bgColor;

  const DoctorCard(this._name, this._description, this._imageUrl, this._bgColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: _bgColor,
          borderRadius: BorderRadius.circular(25),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
            ListTile(

              leading:
              Padding(
                padding: const EdgeInsets.only(right: 20,bottom: 20),
                child: AvatarView(
                  radius: 20,
                  borderWidth: 2,
                  borderColor: Colors.grey,
                  avatarType: AvatarType.CIRCLE,
                  imagePath: _imageUrl,
                  placeHolder: Container(
                    child: const Icon(
                      Icons.person,
                      size: 60,
                    ),
                  ),
                  errorWidget: Container(
                    child: const Icon(
                      Icons.error,
                      size: 50,
                    ),
                  ),
                ),
              ),
              title:
              Text(
                _name,
                style: TextStyle(
                  color: kTitleTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle:
              Padding(
                padding: const EdgeInsets.only(top: 10),

                child: Marquee(
                  text: _description,
                  style: TextStyle(
                    fontSize: 15,
                    color: kTitleTextColor.withOpacity(0.9),
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0, // Adjust the blank space between scroll repetitions
                  velocity: 50.0, // Adjust the scrolling speed (pixels per second)
                  pauseAfterRound: Duration(seconds: 1), // Pause duration after each round
                  startPadding: 10.0, // Adjust the initial padding
                  accelerationDuration: Duration(seconds: 1), // Duration to accelerate from 0 to velocity
                  accelerationCurve: Curves.linear, // Acceleration curve
                  decelerationDuration: Duration(milliseconds: 500), // Duration to decelerate to 0 velocity
                  decelerationCurve: Curves.easeOut, // Deceleration curve
                ),

                // SingleChildScrollView(
                //   reverse: true,
                //   scrollDirection: Axis.horizontal,
                //   child: Text(
                //     _description,
                //     style: TextStyle(fontSize: 10,
                //       color: kTitleTextColor.withOpacity(0.9),
                //     ),
                //   ),
                // ),
              ),

            ),
        ),
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
