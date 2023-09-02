import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class DashBoard with ChangeNotifier {
  late String _orderId;

  String get orderId => _orderId;

  void setOrderId(String orderId) {
    _orderId = orderId;
    notifyListeners();
  }
}

class MyRazorpayService {
  final Razorpay _razorpay = Razorpay();

  Future<void> openCheckout(
      int amountInPaise, Function(String) onPaymentSuccess) async {
    var options = {
      'key': 'rzp_test_NvMoASMnGVXKdQ,4oTApk3usdSBucOu7X0fQ7Dn',
      'amount': amountInPaise,
      'name': 'Your App Name',
      'description': 'Test Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
    };

    try {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
              (PaymentSuccessResponse response) {
            // Handle payment success
            String orderId = response.orderId ?? "";
            print(orderId.toString());
            onPaymentSuccess(orderId);
          });

      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
