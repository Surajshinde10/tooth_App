import 'package:flutter/cupertino.dart';

import 'address.dart';

class AppData extends ChangeNotifier {
  late Address pickUpLocation = Address("", "", "", 0.0, 0.0),dropOffLocation;
  // late Address pickUpLocation;


  void updatePickupLocationAddress(Address pickUpAddress){
    pickUpLocation = pickUpAddress ;
    notifyListeners();

  }
  void updateDropOffLocationAddress(Address dropOffAddress)
  {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}