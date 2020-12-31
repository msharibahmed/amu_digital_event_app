import 'package:amui_digital_event_app/screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'screens/bottom_nav_bar.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.greenAccent, primaryColor: Colors.green),
      home: Home(),
    );
  }
}
