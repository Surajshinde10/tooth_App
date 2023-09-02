import 'package:flutter/material.dart';
import 'package:my_tooth_app/controller/dash-board.dart';
import 'package:my_tooth_app/controller/home_controller.dart';
import 'package:provider/provider.dart';

import '../../razorPay/razorpay.dart';

class ProviderApp extends StatelessWidget {
  final Widget child;
  const ProviderApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashBoard(),
        ),
      ],
      child: child,
    );
  }
}
