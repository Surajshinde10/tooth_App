  import 'dart:developer';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';
  import 'package:intl/intl.dart';
  import 'package:my_tooth_app/model/appoiment_details.dart';
  import 'package:my_tooth_app/model/doctorData.dart';
  import 'package:top_snackbar_flutter/custom_snack_bar.dart';
  import 'package:top_snackbar_flutter/top_snack_bar.dart';

  class HomeController extends ChangeNotifier {
    User? currentUser;
    HomeController() {
      fetchDoctorDetails();
      getAppoinmentDetails();
    }

    List<DoctorDetails> vanLIst = [];
    Future<void> fetchDoctorDetails() async {
      vanLIst.clear();
      QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseFirestore
          .instance
          .collectionGroup('doctorCollection')
          .get();
      vanLIst.clear();
      final list = snapshots.docs
          .map((docSnap) => DoctorDetails.fromSnapshot(docSnap))
          .toList();
      vanLIst.addAll(list);
      log(vanLIst[0].cardColor.toString());

      notifyListeners();
    }

    final nameController = TextEditingController();
    final mobileController = TextEditingController();

    var doctorName = '';
    var doctorBookingDate = '';
    var bookingStatus = '';
    String? userName;
    void doctorNameFun(String d) {
      doctorName = d;
      log(doctorName.toString());
      notifyListeners();
    }

    void bookingStatusFun(String d) {
      bookingStatus = d;
      log(bookingStatus.toString());
      notifyListeners();
    }

    void doctorBookingDateFun(String d) {
      doctorBookingDate = d;
      log(doctorBookingDate.toString());
      notifyListeners();
    }


    Future<void> addData(BuildContext context) async {
      final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      FlutterSecureStorage prefs = const FlutterSecureStorage();
      var name = await prefs.read(key: 'name');
      try {
        await FirebaseFirestore.instance.collection('booking_data').doc(currentDate).collection(name.toString()).add({
          "time_slot": doctorBookingDate,
          "status": bookingStatus,
          "doctor_name": doctorName,
          "patient_name": name,
          "date": DateFormat('dd/MM/yyyy').format(DateTime.now())
        });

        showTopSnackBar(
          // ignore: use_build_context_synchronously
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Appointment booked successfully!',
          ),
        );
        print("Appointment added to collection successfully!");
      } catch (error) {
        print("Failed to add item to collection: $error");
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Failed to book appointment. Please try again.',
          ),
        );
      }
    }

    // Future<void> addData(BuildContext context) async {
    //   final FirebaseAuth auth = FirebaseAuth.instance;
    //   final User? user = auth.currentUser;
    //
    //   // if (user == null) {
    //   //   // Handle the case when the user is not authenticated
    //   //   return;
    //   // }
    //
    //   final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    //   FlutterSecureStorage prefs = const FlutterSecureStorage();
    //   var name = await prefs.read(key: 'name');
    //   try {
    //     await FirebaseFirestore.instance
    //         .collection('booking_data')
    //         .doc(currentDate)
    //         .collection(name.toString())
    //         .add({
    //       "time_slot": doctorBookingDate,
    //       "status": bookingStatus,
    //       "doctor_name": doctorName,
    //       "patient_name": name.toString(), // Use the user's display name
    //       "date": DateFormat('dd/MM/yyyy').format(DateTime.now())
    //     });
    //
    //     showTopSnackBar(
    //       Overlay.of(context),
    //       const CustomSnackBar.success(
    //         message: 'Appointment booked successfully!',
    //       ),
    //     );
    //
    //     print("Appointment added to collection successfully!");
    //   } catch (error) {
    //     print("Failed to add item to collection: $error");
    //     showTopSnackBar(
    //       Overlay.of(context),
    //       const CustomSnackBar.error(
    //         message: 'Failed to book appointment. Please try again.',
    //       ),
    //     );
    //   }
    // }





    List<AppintmentModel> appoimentDetails = [];

    Future<void> getAppoinmentDetails() async {
      FlutterSecureStorage prefs = const FlutterSecureStorage();

      final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      var name = await prefs.read(key: 'name');
      appoimentDetails.clear();
      QuerySnapshot<Map<String, dynamic>> snapshots =
      await FirebaseFirestore.instance.collection("booking_data").doc(currentDate).collection(name.toString()).get();

      // await FirebaseFirestore.instance.collectionGroup('booking_data').get();
      appoimentDetails.clear();
      final list = snapshots.docs
          .map((docSnap) => AppintmentModel.fromSnapshot(docSnap))
          .toList();
      appoimentDetails.addAll(list);
      log(appoimentDetails[0].patientname.toString());

      notifyListeners();
    }

    List<AppintmentModel> pastappoimentDetails = [];
    Future<void> getPastAppointments() async {
      pastappoimentDetails.clear();
      QuerySnapshot<Map<String, dynamic>> snapshots =
      await FirebaseFirestore.instance.collectionGroup('past_booking_data').get();
      pastappoimentDetails.clear();
      final list = snapshots.docs
          .map((docSnap) => AppintmentModel.fromSnapshot(docSnap))
          .toList();
      pastappoimentDetails.addAll(list);
      log(pastappoimentDetails[0].patientname.toString());

      notifyListeners();
    }
  }
