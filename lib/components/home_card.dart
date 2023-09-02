// import 'package:avatar_view/avatar_view.dart';
// import 'package:flutter/material.dart';
//
// import '../utils/constant.dart';
//
// class DoctorCard extends StatelessWidget {
//   final _name;
//   final _description;
//   final _imageUrl;
//   final _bgColor;
//
//
//
//   const DoctorCard(this._name, this._description, this._imageUrl, this._bgColor,
//       {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
//       child: DecoratedBox(
//         decoration: BoxDecoration(shape: BoxShape.rectangle,
//           color: _bgColor,
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: ListTile(
//             leading:
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: AvatarView(
//                 radius: 25,
//                 borderWidth: 3,
//                 borderColor: Colors.white54,
//                 avatarType: AvatarType.CIRCLE,
//                 backgroundColor: Colors.red,
//                 imagePath: _imageUrl,
//                 placeHolder: Container(
//                   child: const Icon(Icons.person, size: 60,),
//                 ),
//                 errorWidget: Container(
//                   child: const Icon(Icons.error, size: 50,),
//                 ),
//               ),
//             ),
//
//
//             title: Text(
//               _name,
//               style: TextStyle(
//                 color: kTitleTextColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             subtitle: Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Text(
//                 _description,
//                 style: TextStyle(
//                   color: kTitleTextColor.withOpacity(0.9),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
