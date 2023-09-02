// import 'package:flutter/material.dart';
// import 'package:my_tooth_app/model/doctorData.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/home_controller.dart';
// import '../utils/constant.dart';
//
// class ScheduleCard extends StatelessWidget {
//   final _title;
//   final _description;
//   final _date;
//   final _month;
//   final _bgColor;
//
//   const ScheduleCard(
//       this._title, this._description, this._date, this._month, this._bgColor,
//       {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//           Padding(
//             padding: const EdgeInsets.only(top: 10,bottom: 10),
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 // color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 color: _bgColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: ListTile(
//                   leading: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                     ),
//                     decoration: BoxDecoration(
//                       color: _bgColor.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           _date,
//                           style: TextStyle(
//                             color: _bgColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           _month,
//                           style: TextStyle(
//                             color: _bgColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     _title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: kTitleTextColor,
//                     ),
//                   ),
//                   subtitle: Text(
//                     _description,
//                     style: TextStyle(
//                       color: kTitleTextColor.withOpacity(0.7),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//            );
//
//
//
//   }
// }

import 'package:flutter/material.dart';

import '../utils/constant.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final String date;
  final String dayOfMonth;
  final String month;
  final List<Color> cardColors;
  final int index; // Add an index property



  ScheduleCard(this.title, this.date, this.dayOfMonth, this.month,this.cardColors, this.index

      );




  @override
  Widget build(BuildContext context) {
    final selectedColor = cardColors[index % cardColors.length]; // Get color based on the index

    return
      Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              height: MediaQuery.of(context).size.height/8,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                // You can also add other decorations like a border
                // border: Border.all(width: 0.6, color: primary),
              ),
              child:
              Column(

                children: [
                  Icon(Icons.calendar_month,size: 30,color: Colors.grey,),

                  Text(' $dayOfMonth $month', style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold)),

                  Center(child: Text(date, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.grey))),
                ],
              ),
            ),

          ],
        ),
      );


  }
  // Widget build(BuildContext context) {
  //   return
  //     DecoratedBox(
  //       decoration: BoxDecoration(
  //         color: cardColor.withOpacity(0.1),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.all(10),
  //         child: ListTile(
  //           leading: Container(
  //             padding: EdgeInsets.symmetric(
  //               horizontal: 16,
  //             ),
  //             decoration: BoxDecoration(
  //               color: cardColor.withOpacity(0.3),
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Text(
  //                   dayOfMonth,
  //                   style: TextStyle(
  //                     color: cardColor,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   date,
  //                   style: TextStyle(
  //                     color: cardColor,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           title: Text(
  //             title,
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: kTitleTextColor,
  //             ),
  //           ),
  //           // subtitle: Text(
  //           //   _description,
  //           //   style: TextStyle(
  //           //     color: kTitleTextColor.withOpacity(0.7),
  //           //   ),
  //           // ),
  //         ),
  //       ),
  //     );
  // }
}


// class ScheduleList extends StatelessWidget {
//   final List<Map<String, dynamic>> scheduleData = [
//     {
//       'title': 'Consultation 1',
//       'date': 'Sunday . 10:00 AM - 12:00 PM',
//       'dayOfMonth': '13',
//       'month': 'Jan',
//
//     },
//     {
//       'title': 'Consultation 2',
//       'date': 'Monday . 3:00 PM - 5:00 PM',
//       'dayOfMonth': '14',
//       'month': 'Jan',
//
//     },
//     // Add more entries here
//   ];
//
//   final List<Color> cardColors = [
//     Colors.yellow,
//     Colors.green,
//     // Add more colors for other indexes
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: scheduleData.length,
//       itemBuilder: (context, index) {
//         final schedule = scheduleData[index];
//         final cardColor = cardColors[index % cardColors.length]; // Index-based color
//
//         return
//           Column(children: [
//
//             ScheduleCard(
//               schedule['title'],
//               schedule['date'],
//               schedule['dayOfMonth'],
//               schedule['month'],
//               cardColor,
//
//             ),
//             SizedBox(height: 16),
//
//           ],
//
//
//           );
//
//       },
//     );
//   }
// }

