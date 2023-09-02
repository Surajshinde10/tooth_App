// // void initState() {
// //   super.initState();
// //
// //   SharedPreferences.getInstance().then((prefs) {
// //     final imagePath = prefs.getString('profileImagePath');
// //     if (imagePath != null) {
// //       setState(() {
// //         _profilePhoto = File(imagePath);
// //       });
// //     }
// //   });
// //
// //   // Other initState code...
// // }
// Scaffold(
// body: Stack(
// children: [
// // Your existing screen content
// SingleChildScrollView(
// child: Column(
// // Your existing content here
// ),
// ),
// // ScaffoldMessenger for displaying SnackBars at the bottom
// Align(
// alignment: Alignment.bottomCenter,
// child: Builder(
// builder: (context) {
// return ScaffoldMessenger(
// child: Container(
// padding: EdgeInsets.all(16),
// color: Colors.black.withOpacity(0.7), // Background color
// child: SnackBar(
// content: Text(
// 'Please add',
// style: TextStyle(fontSize: 18, color: Colors.white),
// ),
// ),
// ),
// );
// },
// ),
// ),
// ],
// ),
// )
