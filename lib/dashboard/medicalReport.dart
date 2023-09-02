import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tooth_app/utils/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Report App',
      home: MedicalReportForm(),
    );
  }
}

class MedicalReportForm extends StatefulWidget {
  @override
  _MedicalReportFormState createState() => _MedicalReportFormState();
}

class _MedicalReportFormState extends State<MedicalReportForm> {

  Uint8List? _selectedImageBytes;
  File? _image;
  File? _cameraImage;
  File? _galleryImage;
  String? _cameraImagePath;
  String? _galleryImagePath;
  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _cameraImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _galleryImagePath = pickedFile.path;
      });
    }
  }

  String? selectedDiagnosis;
  String? name;
  int? age;
  DateTime? lastVisitedDate;
  String? address;




  List<String> diagnoses = [
    'Restoration Of Teeth',
    'Cavity',
    'Dental Implant',
    'Diagnosis 4',
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Report Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Display the selected image

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 70),
                    child: IconButton(
                      onPressed: _getImageFromCamera,
                      icon: Icon(Icons.camera_alt,size: 50,), // Camera icon
                      tooltip: 'Take a Photo',
                    ),
                  ),
                  IconButton(
                    onPressed: _getImageFromGallery,
                    icon: Icon(Icons.image_rounded,size: 50,), // Camera icon
                    tooltip: 'Take a Photo',
                  ),
                  // Add any other buttons or widgets here
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10,),
                  Text(" Upload Camera Image",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
                  SizedBox(width: 20,),
                  Text("Upload Gallary Image",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
                ],
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kDoctorCard1,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton<String>(
                        isExpanded: true, // Make the dropdown take up the full width
                        hint: Text('Select Diagnosis'),
                        value: selectedDiagnosis,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDiagnosis = newValue;
                          });
                        },
                        items: diagnoses.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16.0, // Adjust font size
                              ),
                            ),
                          );
                        }).toList(),
                        underline: Container(),

                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height/18,
                      width: MediaQuery.of(context).size.width/1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          contentPadding: EdgeInsets.only(left: 8.0, right: 8.0), // Add padding here
                          border: InputBorder.none, // Set border to none


                        ),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height/18,
                      width: MediaQuery.of(context).size.width/1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Age',
                          contentPadding: EdgeInsets.only(left: 8.0, right: 8.0), // Add padding here
                          border: InputBorder.none, // Set border to none


                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            age = int.tryParse(value);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height/18,
                      width: MediaQuery.of(context).size.width/1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last Visited Date',
                          contentPadding: EdgeInsets.only(left: 8.0, right: 8.0), // Add padding here
                          border: InputBorder.none, // Set border to none


                        ),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                lastVisitedDate = value;
                              });
                            }
                          });
                        },
                        controller: TextEditingController(
                          text: lastVisitedDate != null
                              ? "${lastVisitedDate!.day}/${lastVisitedDate!.month}/${lastVisitedDate!.year}"
                              : "",
                        ),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height/18,
                      width: MediaQuery.of(context).size.width/1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          contentPadding: EdgeInsets.only(left: 8.0, right: 8.0), // Add padding here
                          border: InputBorder.none, // Set border to none


                        ),
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height/18,
                      width: MediaQuery.of(context).size.width/1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle form submission here, you can print the collected data for now
                          print('Name: $name');
                          print('Age: $age');
                          print('Last Visited Date: $lastVisitedDate');
                          print('Address: $address');
                          print('Diagnosis: $selectedDiagnosis');
                        },
                        child: Text('Submit'),
                      ),
                    ),
                    // Add other fields and buttons as needed for your medical report form
                  ],
                ),
              ),

              // Add other fields and buttons as needed for your medical report form
            ],
          ),
        ),
      ),
    );
  }
}
