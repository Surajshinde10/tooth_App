import 'package:flutter/material.dart';
import 'package:my_tooth_app/utils/constant.dart';
import '../sales_gallary/sales_gallary.dart';
import 'main_dashboard_screen.dart';
import 'medicalReport.dart';
import 'myAppointmentPage.dart';

class BottomNaviPage extends StatefulWidget {
  const BottomNaviPage({super.key});

  @override
  _BottomNaviPageState createState() => _BottomNaviPageState();
}

class _BottomNaviPageState extends State<BottomNaviPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    MainDashboard(),
    AppointmentScreen(),
    DentistSalesGallery(),
    MedicalReportForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (index) {
          // Update the state when a navigation item is tapped
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_customize_outlined,
                color: Colors.black,
              ),
              label: 'DashBoard',
              backgroundColor: kDoctorCard1),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.schedule_outlined,
                color: Colors.black,
              ),
              label: 'My Appointment',
              backgroundColor: kDoctorCard1),
          BottomNavigationBarItem(
                icon: Icon(
                Icons.shop_2_outlined,
                color: Colors.black,
              ),
              label: 'Sales Gallary',
              backgroundColor: Colors.white54),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: "Settings & Profile",
              backgroundColor: Colors.white54),
        ],
    selectedItemColor: Colors.black, // Selected item text color
    unselectedItemColor: Colors.black, // Unselected item text color
    showUnselectedLabels: true, // Set to true if you want to show unselected labels
    selectedLabelStyle: TextStyle(color: kTitleTextColor,fontWeight: FontWeight.bold), // Selected label text style
    unselectedLabelStyle: TextStyle(color: Colors.grey), )// Unselected label text style      ),
    );
  }
}
