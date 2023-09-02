import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDetails {
  String qualification;
  String profilePic;
  dynamic pinCode;
  dynamic phoneNumber;
  String name;
  String location;
  bool isApproved;
  bool isActive;
  String clinicName;
  String bannerImage;
  List<Map<String, dynamic>> availability;
  String address;
  String about;
  String achievements;
  String cardColor;
  double latitude;
  double longitude;
  List<Map<String, dynamic>> Consultation ;


  DoctorDetails({
    required this.qualification,
    required this.profilePic,
    required this.pinCode,
    required this.phoneNumber,
    required this.name,
    required this.location,
    required this.isApproved,
    required this.isActive,
    required this.clinicName,
    required this.bannerImage,
    required this.availability,
    required this.address,
    required this.about,
    required this.achievements,
    required this.cardColor,
    required this.latitude,
    required this.longitude,
    required this.Consultation
  });

  factory DoctorDetails.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DoctorDetails(
      latitude: data['latitude '],
      longitude: data['longitude '],
      qualification: data['qualification'] ?? '',
      profilePic: data['profilePic'] ?? '',
      pinCode: data['pinCode'],
      phoneNumber: data['phoneNumber'],
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      isApproved: data['isApproved'] ?? false,
      isActive: data['isActive'] ?? false,
      clinicName: data['clinicName'] ?? '',
      bannerImage: data['bannerImage'] ?? '',
      address: data['address'] ?? '',
      availability: List<Map<String, dynamic>>.from(data['availability'] ?? []),
      about: data['about'] ?? '',
      achievements: data['acheivments'] ?? '',
       cardColor: data['cardColor'] ?? '',
        Consultation: List<Map<String, dynamic>>.from(data['Consultation'] ?? [])
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







class DoctorCard {
  final String name;
  final String qualifications;
  final String profilePic;
  final Color cardColor;

  DoctorCard(this.name, this.qualifications, this.profilePic, this.cardColor);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qualifications': qualifications,
      'profilePic': profilePic,
      'cardColor': cardColor.value,
    };
  }

  factory DoctorCard.fromJson(Map<String, dynamic> json) {
    return DoctorCard(
      json['name'],
      json['qualifications'],
      json['profilePic'],
      Color(json['cardColor']),
    );
  }
}
