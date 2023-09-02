import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationData {
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int dayOfMonth;
  final String month;

  ConsultationData({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.dayOfMonth,
    required this.month,
  });
}

// Map<String, dynamic> consultationMap = {
//   'dayOfWeek': consultation.dayOfWeek,
//   'startTime': consultation.startTime,
//   'endTime': consultation.endTime,
//   'dayOfMonth': consultation.dayOfMonth,
//   'month': consultation.month,
// };




FirebaseFirestore firestore = FirebaseFirestore.instance;

void saveConsultationToFirestore(ConsultationData consultation) async {
  try {
    Map<String, dynamic> consultationMap = {
      'dayOfWeek': consultation.dayOfWeek,
      'startTime': consultation.startTime,
      'endTime': consultation.endTime,
      'dayOfMonth': consultation.dayOfMonth,
      'month': consultation.month,
    };

    await firestore.collection('consultations').add(consultationMap);
    print('Consultation saved to Firestore');
  } catch (e) {
    print('Error saving consultation: $e');
  }
}


Future<List<ConsultationData>> getConsultationsFromFirestore() async {
  List<ConsultationData> consultations = [];

  try {
    QuerySnapshot snapshot = await firestore.collection('consultations').get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      ConsultationData consultation = ConsultationData(
        dayOfWeek: data['dayOfWeek'],
        startTime: data['startTime'],
        endTime: data['endTime'],
        dayOfMonth: data['dayOfMonth'],
        month: data['month'],
      );
      consultations.add(consultation);
    });

    return consultations;
  } catch (e) {
    print('Error getting consultations: $e');
    return [];
  }
}

