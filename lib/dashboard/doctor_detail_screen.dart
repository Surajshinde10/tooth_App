// import 'dart:developer';
//
// import 'package:avatar_view/avatar_view.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:my_tooth_app/controller/dash-board.dart';
// import 'package:my_tooth_app/controller/home_controller.dart';
// import 'package:my_tooth_app/dashboard/dashBoardMainPage.dart';
// import 'package:my_tooth_app/model/doctorData.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../components/schedule_ConsultationData.dart';
// import '../components/schedule_card.dart';
// import '../razorPay/razorpay.dart';
// import '../utils/constant.dart';
//
// class DetailScreen extends StatelessWidget {
//   final DoctorDetails data;
//
//   // ConsultationData consultation = data.availability[index]; // Assuming this is how you get consultation data
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   DetailScreen({
//     super.key,
//     required this.data,
//   });
//
//   void addSlotsForDay(String date) async {
//     // Reference to the main collection
//     CollectionReference mainCollection =
//         _firestore.collection('main_collection');
//
//     DocumentReference dateDocument = mainCollection.doc(date);
//
//     // List of slots for half-hour intervals
//     List<Map<String, String>> slots = [
//       {
//         'startTime': '08:00 AM',
//         'endTime': '08:30 AM',
//         'data': 'Data for slot1 on $date'
//       },
//
//       {
//         'startTime': '08:30 AM',
//         'endTime': '09:00 AM',
//         'data': 'Data for slot2 on $date'
//       },
//
//       {
//         'startTime': '10:00 AM',
//         'endTime': '11:00 AM',
//         'data': 'Data for slot2 on $date'
//       },
//       // Add more slots as needed
//     ];
//
//     // Add each slot to the document
//     for (int i = 0; i < slots.length; i++) {
//       try {
//         await dateDocument
//             .collection('slots')
//             .doc('slot${i + 1}')
//             .set(slots[i]);
//         print('Slot ${i + 1} added successfully for $date');
//       } catch (e) {
//         print('Error adding slot ${i + 1}: $e');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(data.bannerImage),
//               alignment: Alignment.topCenter,
//               fit: BoxFit.fitWidth,
//             ),
//           ),
//           child: Column(
//             children: <Widget>[
//               const SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: SvgPicture.asset(
//                         'assets/icons/back.svg',
//                         color: Colors.black,
//                         height: 20,
//                       ),
//                     ),
//                     // SizedBox(
//                     //   height: 20,
//                     //   width: 20,
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/3dots.svg',
//                     //     height: 18,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.24,
//               ),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: kBackgroundColor,
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(50),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: AvatarView(
//                               radius: 40,
//                               borderWidth: 3,
//                               borderColor: Colors.grey,
//                               avatarType: AvatarType.CIRCLE,
//                               backgroundColor: Colors.red,
//                               imagePath: data.profilePic,
//                               placeHolder: Container(
//                                 child: const Icon(
//                                   Icons.person,
//                                   size: 60,
//                                 ),
//                               ),
//                               errorWidget: Container(
//                                 child: const Icon(
//                                   Icons.error,
//                                   size: 50,
//                                 ),
//                               ),
//                             ),
//                             // Image.network(
//                             //   data.profilePic,
//                             //   height: 120,
//                             // ),
//                           ),
//                           Flexible(
//                             flex: 3,
//                             child: Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       data.name,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: kTitleTextColor,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       data.achievements,
//                                       style: TextStyle(
//                                         color: kTitleTextColor.withOpacity(0.7),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: <Widget>[
//                                         Container(
//                                           padding: const EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                             color: kBlueColor.withOpacity(0.1),
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           child: SvgPicture.asset(
//                                             'assets/icons/phone.svg',
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 16,
//                                         ),
//                                         // Container(
//                                         //   padding: const EdgeInsets.all(10),
//                                         //   decoration: BoxDecoration(
//                                         //     color:
//                                         //         kYellowColor.withOpacity(0.1),
//                                         //     borderRadius:
//                                         //         BorderRadius.circular(10),
//                                         //   ),
//                                         //   child: SvgPicture.asset(
//                                         //     'assets/icons/chat.svg',
//                                         //   ),
//                                         // ),
//                                         const SizedBox(
//                                           width: 16,
//                                         ),
//                                         // Container(
//                                         //   padding: const EdgeInsets.all(10),
//                                         //   decoration: BoxDecoration(
//                                         //     color:
//                                         //         kOrangeColor.withOpacity(0.1),
//                                         //     borderRadius:
//                                         //         BorderRadius.circular(10),
//                                         //   ),
//                                         //   child: SvgPicture.asset(
//                                         //     'assets/icons/video.svg',
//                                         //   ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       Text(
//                         'About Doctor',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: kTitleTextColor,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         data.about,
//                         style: TextStyle(
//                           height: 1.6,
//                           color: kTitleTextColor.withOpacity(0.7),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Text(
//                         'Book An Appointment',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: kTitleTextColor,
//                         ),
//                       ),
//                       // const SizedBox(
//                       //   height: 10,
//                       // ),
//                       data.availability.isEmpty
//                           ? const Text("No schedules found")
//                           : Consumer<HomeController>(
//                               builder: (context, val, _) => ListView.builder(
//                                 itemCount: data.availability.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   Map<String, dynamic> consultationDataMap =
//                                       data.availability[index];
//
//                                   ConsultationData consultation =
//                                       ConsultationData(
//                                     dayOfWeek:
//                                         consultationDataMap['dayOfWeek'] ?? '',
//                                     startTime:
//                                         consultationDataMap['startTime'] ?? '',
//                                     endTime:
//                                         consultationDataMap['endTime'] ?? '',
//                                     dayOfMonth:
//                                         consultationDataMap['dayOfMonth'] ?? 1,
//                                     month: consultationDataMap['month'] ?? '',
//                                   );
//
//                                   // Get the current date and format it as "dd MMM"
//                                   DateTime currentDate = DateTime.now();
//                                   String formattedDate =
//                                       DateFormat('dd MMM yyyy')
//                                           .format(currentDate);
//
//                                   return GestureDetector(
//                                     onTap: () async {
//                                       val.doctorBookingDateFun(
//                                           '${data.availability.first} - ${data.availability.last}');
//                                       val.doctorNameFun(data.name);
//                                       val.bookingStatusFun(
//                                           data.isActive.toString());
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             backgroundColor: kDoctorCard1,
//                                             title: const Center(
//                                                 child: Text(
//                                               'Appointment Booking',
//                                               style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             )),
//                                             content: const Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 20, right: 20),
//                                               child: Text(
//                                                 'Are you sure you want to Book this Appointment?? ',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 18),
//                                               ),
//                                             ),
//                                             actions: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Consumer<DashBoard>(
//                                                     builder: (context,
//                                                             dashboard, _) =>
//                                                         MaterialButton(
//                                                       color: Colors.green,
//                                                       onPressed: () async {
//                                                         // await val
//                                                         //     .addData(context)
//                                                         //     .whenComplete(() {
//                                                         //   Navigator.push(
//                                                         //       context,
//                                                         //       MaterialPageRoute(
//                                                         //           builder:
//                                                         //               (context) =>
//                                                         //               BottomNavDemo()));
//                                                         //   // Navigator.pop(context);
//                                                         // });
//
//                                                         Razorpay razorpay =
//                                                             Razorpay();
//                                                         var options = {
//                                                           'key':
//                                                               // 'rzp_test_o5sKGAzGO5rJob',
//                                                               'rzp_live_ILgsfZCZoFIKMb',
//                                                           'amount': 1 * 100,
//                                                           'name': 'Tooth app',
//                                                           'description':
//                                                               'My tooth pic app',
//                                                           'retry': {
//                                                             'enabled': true,
//                                                             'max_count': 100
//                                                           },
//                                                           'send_sms_hash': true,
//                                                           'prefill': {
//                                                             'contact':
//                                                                 '8888888888',
//                                                             'email':
//                                                                 'test@razorpay.com'
//                                                           },
//                                                           'external': {
//                                                             'wallets': ['paytm']
//                                                           }
//                                                         };
//                                                         razorpay.on(
//                                                             Razorpay
//                                                                 .EVENT_PAYMENT_ERROR,
//                                                             handlePaymentErrorResponse);
//                                                         razorpay.on(
//                                                             Razorpay
//                                                                 .EVENT_PAYMENT_SUCCESS,
//                                                             (PaymentSuccessResponse response) async {
//                                                           handlePaymentSuccessResponse();
//                                                           await val
//                                                               .addData(context)
//                                                               .whenComplete(() {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 MaterialPageRoute(
//                                                                     builder:
//                                                                         (context) =>
//                                                                             BottomNavDemo()));
//                                                             // Navigator.pop(context);
//                                                           });
//                                                         });
//                                                         razorpay.on(
//                                                             Razorpay
//                                                                 .EVENT_EXTERNAL_WALLET,
//                                                             handleExternalWalletSelected);
//                                                         razorpay.open(options);
//                                                       },
//                                                       child: const Text(
//                                                         'Confirm',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 20,
//                                                   ),
//                                                   MaterialButton(
//                                                     splashColor: Colors.black,
//                                                     // color: Colors.red,
//                                                     onPressed: () =>
//                                                         Navigator.pop(context),
//                                                     child: const Text(
//                                                       'Cancel',
//                                                       style: TextStyle(
//                                                           color: Colors.black),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: ScheduleCard(
//                                       'Available Slot - ${index + 1}',
//                                       '${consultation.dayOfWeek}\n Time : ${consultation.startTime} - ${consultation.endTime}',
//                                       formattedDate, // Use the formatted date here
//                                       consultation.month,
//                                       kYellowColor,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                       // ScheduleCard(
//                       //   'Consultation',
//                       //   'Sunday . 9am - 11am',
//                       //   '12',
//                       //   'Jan',
//                       //   kBlueColor,
//                       // ),
//                       // const SizedBox(
//                       //   height: 10,
//                       // ),
//
//                       // const SizedBox(
//                       //   height: 10,
//                       // ),
//                       // ScheduleCard(
//                       //   'Consultation',
//                       //   'Sunday . 9am - 11am',
//                       //   '14',
//                       //   'Jan',
//                       //   kOrangeColor,
//                       // ),
//                       // const SizedBox(
//                       //   height: 20,
//                       // ),
//                       // Consumer<HomeController>(
//                       //   builder: (context, val, _) => Center(
//                       //     child: ElevatedButton(
//                       //       onPressed: () async {
//                       //         String currentDate =
//                       //             DateTime.now().toString().split(' ')[0];
//                       //         addSlotsForDay(currentDate);
//                       //       },
//                       //       child: const Text('Add Slots for Current Date'),
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   handlePaymentErrorResponse() {
//     log("sds");
//   }
//
//   handlePaymentSuccessResponse() {
//     log("sds");
//   }
//
//   handleExternalWalletSelected() {
//     log("sds");
//   }
// }


import 'dart:developer';

import 'package:avatar_view/avatar_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_tooth_app/controller/dash-board.dart';
import 'package:my_tooth_app/controller/home_controller.dart';
import 'package:my_tooth_app/dashboard/dashBoardMainPage.dart';
import 'package:my_tooth_app/model/doctorData.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/schedule_ConsultationData.dart';
import '../components/schedule_card.dart';
import '../razorPay/razorpay.dart';
import '../utils/constant.dart';

class DetailScreen extends StatelessWidget {
  final DoctorDetails data;


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DetailScreen({
    super.key,
    required this.data,
  });

  final List<Color> cardColors = [
    kDoctorCard1,
    kSearchBackgroundColor,
    kSearchTextColor,
  ];

  void addSlotsForDay(String date) async {
    // Reference to the main collection
    CollectionReference mainCollection =
    _firestore.collection('main_collection');

    DocumentReference dateDocument = mainCollection.doc(date);

    // List of slots for half-hour intervals
    List<Map<String, String>> slots = [
      {
        'startTime': '08:00 AM',
        'endTime': '08:30 AM',
        'data': 'Data for slot1 on $date'
      },

      {
        'startTime': '08:30 AM',
        'endTime': '09:00 AM',
        'data': 'Data for slot2 on $date'
      },

      {
        'startTime': '10:00 AM',
        'endTime': '11:00 AM',
        'data': 'Data for slot2 on $date'
      },
      // Add more slots as needed
    ];

    // Add each slot to the document
    for (int i = 0; i < slots.length; i++) {
      try {
        await dateDocument
            .collection('slots')
            .doc('slot${i + 1}')
            .set(slots[i]);
        print('Slot ${i + 1} added successfully for $date');
      } catch (e) {
        print('Error adding slot ${i + 1}: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(data.bannerImage),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        color: Colors.black,
                        height: 20,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:
                            AvatarView(
                              radius: 40,
                              borderWidth: 3,
                              borderColor: Colors.grey,
                              avatarType: AvatarType.CIRCLE,
                              backgroundColor: Colors.red,
                              imagePath: data.profilePic,
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
                          Flexible(
                            flex: 3,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: kTitleTextColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.achievements,
                                      style: TextStyle(
                                        color: kTitleTextColor.withOpacity(0.7),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        try {
                                          _makePhoneCall(data.phoneNumber);
                                        } catch (e) {
                                          print('Error: $e');
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: kBlueColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/phone.svg',
                                          color: Colors.green,
                                        ),
                                      ),
                                    )


                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'About Doctor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.about,
                        style: TextStyle(
                          height: 1.6,
                          color: kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Book An Appointment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),

                      data.availability.isEmpty
                          ? const Text("No schedules found")
                          : Consumer<HomeController>(
                        builder: (context, val, _) =>


                        CarouselSlider(
                          options: CarouselOptions(
                            // Configure carousel options as needed
                            // For example, you can set height, enable auto-scrolling, etc.
                          ),
                          items:data.availability.asMap().entries.map((entry) {
                            final index = entry.key; // Access the index
                            final consultationDataMap = entry.value;
                            ConsultationData consultation = ConsultationData(
                              dayOfWeek: consultationDataMap['dayOfWeek'] ?? '',
                              startTime: consultationDataMap['startTime'] ?? '',
                              endTime: consultationDataMap['endTime'] ?? '',
                              dayOfMonth: consultationDataMap['dayOfMonth'] ?? 1,
                              month: consultationDataMap['month'] ?? '',
                            );

                            // Get the current date and format it as "dd MMM"
                            DateTime currentDate = DateTime.now();
                            String formattedDate = DateFormat('dd MMM yyyy').format(currentDate);

                            return GestureDetector(
                              onTap: () async {
                                val.doctorBookingDateFun(
                                    '${data.availability.first} - ${data.availability.last}');
                                val.doctorNameFun(data.name);
                                val.bookingStatusFun(
                                    data.isActive.toString());
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: kDoctorCard1,
                                      title: const Center(
                                          child: Text(
                                            'Appointment Booking',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                      content: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                          'Are you sure you want to Book this Appointment?? ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Consumer<DashBoard>(
                                              builder: (context,
                                                  dashboard, _) =>
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    onPressed: () async {


                                                      Razorpay razorpay =
                                                      Razorpay();
                                                      var options = {
                                                        'key':
                                                        'rzp_test_o5sKGAzGO5rJob',
                                                        // 'rzp_live_ILgsfZCZoFIKMb',
                                                        'amount': 1 * 100,
                                                        'name': 'Tooth app',
                                                        'description':
                                                        'My tooth pic app',
                                                        'retry': {
                                                          'enabled': true,
                                                          'max_count': 100
                                                        },
                                                        'send_sms_hash': true,
                                                        'prefill': {
                                                          'contact':
                                                          '8888888888',
                                                          'email':
                                                          'test@razorpay.com'
                                                        },
                                                        'external': {
                                                          'wallets': ['paytm']
                                                        }
                                                      };
                                                      razorpay.on(
                                                          Razorpay
                                                              .EVENT_PAYMENT_ERROR,
                                                          handlePaymentErrorResponse);
                                                      razorpay.on(
                                                          Razorpay
                                                              .EVENT_PAYMENT_SUCCESS,
                                                              (PaymentSuccessResponse response) async {
                                                            handlePaymentSuccessResponse();
                                                            await val
                                                                .addData(context)
                                                                .whenComplete(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                          BottomNaviPage()));
                                                              // Navigator.pop(context);
                                                            });
                                                          });
                                                      razorpay.on(
                                                          Razorpay
                                                              .EVENT_EXTERNAL_WALLET,
                                                          handleExternalWalletSelected);
                                                      razorpay.open(options);
                                                    },
                                                    child: const Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    ),
                                                  ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            MaterialButton(
                                              splashColor: Colors.black,
                                              // color: Colors.red,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ScheduleCard(
                                'Slot - ${index + 1}',
                                '${consultation.dayOfWeek}\n Time : ${consultation.startTime} - ${consultation.endTime}',
                                formattedDate, // Use the formatted date here
                                consultation.month,
                                cardColors,
                                index,
                              ),
                            );
                          }).toList(),
                        ),



                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  handlePaymentErrorResponse() {
    log("sds");
  }

  handlePaymentSuccessResponse() {
    log("sds");
  }

  handleExternalWalletSelected() {
    log("sds");
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}