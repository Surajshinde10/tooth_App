
import 'package:avatar_view/avatar_view.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:my_tooth_app/controller/home_controller.dart';
import 'package:provider/provider.dart';
import '../utils/constant.dart';

class AppointmentScreen extends StatelessWidget {
  final List<Appointment> upcomingAppointments = []; // Populate with data
  final List<Appointment> recentAppointments = [];   // Populate with data




  @override
  Widget build(BuildContext context) {
    context.read<HomeController>().getAppoinmentDetails();
    context.read<HomeController>().getPastAppointments();
    return

      MaterialApp(

        debugShowCheckedModeBanner: false,
        home: Consumer<HomeController>(builder: (context,value,_) =>
            DefaultTabController(
              length: 2, // Number of tabs
              child: Scaffold(
                backgroundColor: kScaffoldBackground,
                appBar: AppBar(backgroundColor: kDoctorCard1,shadowColor: secondary,
                  title: Center(child: Text('Appointments',style: TextStyle(color:primary,fontSize: 18,fontWeight: FontWeight.bold,),)),
                  bottom: TabBar(

                    labelColor: Colors.black,    // Active tab text color
                    unselectedLabelColor: Colors.grey, // Inactive tab text color
                    tabs: [

                      Tab(text: 'Recent', ),
                      Tab(text: 'Past'),
                    ],
                  ),
                ),
                body:
                TabBarView(
                  children: [
                    // Container(
                    //
                    //   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),boxShadow: [
                    //   //   BoxShadow(color: kSearchBackgroundColor, spreadRadius: 3,),
                    //   // ],),
                    //   height: MediaQuery.of(context).size.height/4,
                    //   width: MediaQuery.of(context).size.width/0.5,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: value.appoimentDetails.length,
                    //     itemBuilder: (context, index) {
                    //
                    //       final appointment = value.appoimentDetails[index];
                    //
                    //       return Padding(
                    //         padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
                    //         child: DecoratedBox(
                    //           decoration: BoxDecoration(shape: BoxShape.rectangle,
                    //             color: kDoctorCard1,
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    //             child: ListTile(
                    //               trailing: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(right: 250,top: 8),
                    //                     child: CircleAvatar(
                    //                       radius: 30,
                    //                       child: Image.asset('assets/Profile_picture.png'),
                    //
                    //                     ),
                    //                   ),
                    //                   // Padding(
                    //                   //   padding: const EdgeInsets.only(top: 30),
                    //                   //   child: Text(
                    //                   //     "Patient Name : " +"${appointment.patientname}" ?? "",
                    //                   //     style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
                    //                   //   ),
                    //                   // ),
                    //                   // SizedBox(height: 5,),
                    //                   // Text("Name : " + "${appointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                    //                   // Text("Date : " + "${appointment.date}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                    //
                    //                 ],
                    //               ),
                    //
                    //
                    //               onTap: () {
                    //                 showDialog(
                    //                   context: context,
                    //                   builder: (context) => AlertDialog(
                    //                     backgroundColor: kDoctorCard1,
                    //                     title: Center(child: Text(appointment.doctorName ?? "")),
                    //                     content: Text('Time slot: ${appointment.timeslot}\n\n'
                    //                         'Date: ${appointment.date}\n'),
                    //                     actions: [
                    //                       TextButton(
                    //                         onPressed: () => Navigator.pop(context),
                    //                         child: const Text('Close'),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Upcoming Appointments Tab
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    //   child: Container(
                    //     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),boxShadow: [
                    //     //   BoxShadow(color: kSearchBackgroundColor, spreadRadius: 3,),
                    //     // ],),
                    //     height: MediaQuery.of(context).size.height/3,
                    //     width: MediaQuery.of(context).size.width/0.5,
                    //     child: ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: value.appoimentDetails.length,
                    //       itemBuilder: (context, index) {
                    //
                    //         final appointment = value.appoimentDetails[index];
                    //         // final appointment = currentUserAppointments[index];
                    //         if(appointment.patientId == appointment.patientId) {
                    //           return   Padding(
                    //             padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                    //             child: DecoratedBox(
                    //               decoration: BoxDecoration(border: Border.all(color: Colors.black),shape: BoxShape.rectangle,
                    //                 color: Colors.cyanAccent,
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    //                 child: ListTile(
                    //                   title: Text(
                    //                     "Patient Name : " +"${value.currentUser}" ?? "",
                    //                     style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
                    //                   ),
                    //                   subtitle: Text("Name : " + "${appointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                    //                   trailing: Text(
                    //                     '${appointment.date}',
                    //                   ),
                    //                   onTap: () {
                    //                     showDialog(
                    //                       context: context,
                    //                       builder: (context) => AlertDialog(
                    //                         backgroundColor: kDoctorCard1,
                    //                         title: Center(child: Text(appointment.doctorName ?? "")),
                    //                         content: Text('Time slot: ${appointment.timeslot}\n\n'
                    //                             'Date: ${appointment.date}\n'),
                    //                         actions: [
                    //                           TextButton(
                    //                             onPressed: () => Navigator.pop(context),
                    //                             child: const Text('Close'),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     );
                    //                   },
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //           return Container();
                    //         }else{
                    //
                    //         }
                    //
                    //
                    //
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Recent Appointments Tab
                    SingleChildScrollView(
                      child: Container(

                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.appoimentDetails.length,
                          itemBuilder: (context, index) {

                            Color backgroundColor;

                            // Define a list of colors to cycle through
                            List<Color> colors = [kDoctorCard1, kDoctorCard2, Colors.green];

                            // Use modulo operator to cycle through colors based on index
                            backgroundColor = colors[index % colors.length];

                            final appointment = value.appoimentDetails[index];
                            if(appointment.patientname == appointment.patientname){
                              return Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(shape: BoxShape.rectangle,
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 25,
                                        // Display the doctor's profile photo using the Image.network widget
                                        backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/002/896/807/original/female-doctor-using-her-digital-tablet-free-vector.jpg"),
                                      ),
                                      title: Text(
                                        "Patient : " +"${appointment.patientname}" ?? "",
                                        style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
                                      ),
                                      subtitle: Text("Name : " + "${appointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                                      trailing: Text(
                                        '${appointment.date}',
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(appointment.doctorName ?? ""),
                                            content: Text('Time slot: ${appointment.timeslot}\n\n'
                                                'Date: ${appointment.date}\n'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }


                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width/0.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.pastappoimentDetails.length,
                          itemBuilder: (context, index) {

                            final pastappointment = value.pastappoimentDetails[index];
                            if(pastappointment.patientname == pastappointment.patientname){
                              return Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black),shape: BoxShape.rectangle,
                                    color: Colors.cyanAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                    child: ListTile(
                                      title: Text(
                                        "Patient Name : " +"${pastappointment.patientname}" ?? "",
                                        style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
                                      ),
                                      subtitle: Text("Name : " + "${pastappointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                                      trailing: Text(
                                        '${pastappointment.date}',
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(pastappointment.doctorName ?? ""),
                                            content: Text('Time slot: ${pastappointment.timeslot}\n\n'
                                                'Date: ${pastappointment.date}\n'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }


                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),),

      );
  }
}

class Appointment {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final DateTime dateTime;


  Appointment(
      {required this.id,
        required this.title,
        required this.date,
        required this.description,
      required this.dateTime});
}

class AppointmentHistoryPage extends StatelessWidget {
  var _selectedValue = "";
  final List<Appointment> appointments = [
    Appointment(
      id: '1',
      title: 'Dentist Appointment',
      date: DateTime(2023, 7, 15, 14, 30),
      description: 'Regular checkup', dateTime: DateTime.now(),
    ),
    Appointment(dateTime: DateTime.now(),
      id: '2',
      title: 'Doctor Appointment',
      date: DateTime(2023, 7, 20, 10, 0),
      description: 'Follow-up visit',
    ),
    // Add more appointments as needed
  ];



  AppointmentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<HomeController>().getAppoinmentDetails();
    context.read<HomeController>().getPastAppointments();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<HomeController>(
        builder: (context, value, _) =>
            Scaffold(
          appBar: AppBar(
            backgroundColor: kDoctorCard1,
            title: Center(child: Text('Appointment History',style: TextStyle(color: Colors.black),)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15,),

                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    // setState(() {
                    //   // _selectedValue = date;
                    // });
                  },
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text("Recent Appointment",style: TextStyle(color: Colors.black,fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),boxShadow: [
                      BoxShadow(color: kSearchBackgroundColor, spreadRadius: 3,),
                    ],),
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width/0.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.appoimentDetails.length,
                      itemBuilder: (context, index) {

                        final appointment = value.appoimentDetails[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                          child: DecoratedBox(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black),shape: BoxShape.rectangle,
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                              child: ListTile(
                                title: Text(
                                  "Patient Name : " +"${appointment.patientname}" ?? "",
                                  style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
                                ),
                                subtitle: Text("Name : " + "${appointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                                trailing: Text(
                                  '${appointment.date}',
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: kDoctorCard1,
                                      title: Center(child: Text(appointment.doctorName ?? "")),
                                      content: Text('Time slot: ${appointment.timeslot}\n\n'
                                          'Date: ${appointment.date}\n'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text("Past Appointments",style: TextStyle(color: Colors.black,fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height/3,
                    width: MediaQuery.of(context).size.width/0.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.pastappoimentDetails.length,
                      itemBuilder: (context, index) {

                        final pastappointment = value.pastappoimentDetails[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                          child: DecoratedBox(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black),shape: BoxShape.rectangle,
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                              child: ListTile(
                                title: Text(
                                  "Patient Name : " +"${pastappointment.patientname}" ?? "",
                                  style: const TextStyle(color: Colors.black,fontSize: 16,fontStyle: FontStyle.normal),
                                ),
                                subtitle: Text("Name : " + "${pastappointment.doctorName}" ?? "",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 14),),
                                trailing: Text(
                                  '${pastappointment.date}',
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(pastappointment.doctorName ?? ""),
                                      content: Text('Time slot: ${pastappointment.timeslot}\n\n'
                                          'Date: ${pastappointment.date}\n'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),



        ),
      ),
    );
  }
}
