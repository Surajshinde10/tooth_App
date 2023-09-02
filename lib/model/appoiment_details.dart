import 'package:cloud_firestore/cloud_firestore.dart';

class AppintmentModel {
  String? date;
  String? doctorName;
  String? isApproved;
  String? patientname;
  String? timeslot;
  final String patientId;


  AppintmentModel({
    this.date,
    this.doctorName,
    this.isApproved,
    this.patientname,
    this.timeslot,
    required this.patientId
  });
  factory AppintmentModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AppintmentModel(
      date: data['date'] ?? '',
      doctorName: data['doctor_name'] ?? '',
      isApproved: data['status'],
      patientname: data['patient_name'],
      timeslot: data['time_slot'] ?? "",
      patientId: data['patientId'] ?? "",
    );
  }
}

class Availability {
  String startingTime;
  String endingTime;

  Availability({
    required this.startingTime,
    required this.endingTime,
  });

  factory Availability.fromMap(Map<String, dynamic> data) {
    return Availability(
      startingTime: data['startingTime'] ?? '',
      endingTime: data['endingTime'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startingTime': startingTime,
      'endingTime': endingTime,
    };
  }
}
