// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/home_controller.dart';
// import '../dashboard/myAppointmentPage.dart';
// import '../utils/constant.dart';
//
//
//
// class AppointmentScreen extends StatelessWidget {
//   final List<Appointment> upcomingAppointments = []; // Populate with data
//   final List<Appointment> recentAppointments = [];   // Populate with data
//
//   @override
//   Widget build(BuildContext context) {
//     context.read<HomeController>().getAppoinmentDetails();
//     context.read<HomeController>().getPastAppointments();
//     return
//
//       MaterialApp(
//
//         debugShowCheckedModeBanner: false,
//         home: Consumer<HomeController>(builder: (context,value,_) =>
//             DefaultTabController(
//               length: 2, // Number of tabs
//               child: Scaffold(
//                 backgroundColor: kScaffoldBackground,
//                 appBar: AppBar(backgroundColor: Colors.grey,
//                   title: Center(child: const Text('Appointments',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),)),
//                   bottom: TabBar(
//                     tabs: [
//                       Tab(text: 'Recent',),
//                       Tab(text: 'Upcoming'),
//                     ],
//                   ),
//                 ),
//                 body: TabBarView(
//                   children: [
//                     // Upcoming Appointments Tab
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
//                       child: Container(
//                         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),boxShadow: [
//                         //   BoxShadow(color: kSearchBackgroundColor, spreadRadius: 3,),
//                         // ],),
//                         height: MediaQuery.of(context).size.height/4,
//                         width: MediaQuery.of(context).size.width/0.5,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: value.appoimentDetails.length,
//                           itemBuilder: (context, index) {
//
//                             final appointment = value.appoimentDetails[index];
//
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//                               child: DecoratedBox(
//                                 decoration: BoxDecoration(border: Border.all(color: Colors.black),shape: BoxShape.rectangle,
//                                   color: Colors.cyanAccent,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
//                                   child: ListTile(
//                                     title: Text(
//                                       "Patient Name : " +"${appointment.patientname}" ?? "",
//                                       style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
//                                     ),
//                                     subtitle: Text("Name : " + "${appointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
//                                     trailing: Text(
//                                       '${appointment.date}',
//                                     ),
//                                     onTap: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) => AlertDialog(
//                                           backgroundColor: kDoctorCard1,
//                                           title: Center(child: Text(appointment.doctorName ?? "")),
//                                           content: Text('Time slot: ${appointment.timeslot}\n\n'
//                                               'Date: ${appointment.date}\n'),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () => Navigator.pop(context),
//                                               child: const Text('Close'),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     // Recent Appointments Tab
//
//
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height/3,
//                         width: MediaQuery.of(context).size.width/0.5,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: value.pastappoimentDetails.length,
//                           itemBuilder: (context, index) {
//
//                             final pastappointment = value.pastappoimentDetails[index];
//
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//                               child: DecoratedBox(
//                                 decoration: BoxDecoration(border: Border.all(color: Colors.black),shape: BoxShape.rectangle,
//                                   color: Colors.cyanAccent,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
//                                   child: ListTile(
//                                     title: Text(
//                                       "Patient Name : " +"${pastappointment.patientname}" ?? "",
//                                       style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
//                                     ),
//                                     subtitle: Text("Name : " + "${pastappointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
//                                     trailing: Text(
//                                       '${pastappointment.date}',
//                                     ),
//                                     onTap: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) => AlertDialog(
//                                           title: Text(pastappointment.doctorName ?? ""),
//                                           content: Text('Time slot: ${pastappointment.timeslot}\n\n'
//                                               'Date: ${pastappointment.date}\n'),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () => Navigator.pop(context),
//                                               child: const Text('Close'),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),),
//
//       );
//   }
// }
