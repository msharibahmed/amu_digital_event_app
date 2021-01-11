import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/https.dart';
import 'screens/bottom_nav_bar.dart';
import 'screens/notices.dart';
import 'screens/holidays.dart';
import 'screens/events.dart';
import 'screens/settings.dart';
import 'screens/home.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Https>(create: (_) => Https()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
            accentColor: Colors.indigo,
            primaryColor: Colors.orange),
        routes: {
          Home.routeName: (context) => Home(),
          Notices.routeName: (context) => Notices(),
          Events.routeName: (context) => Events(),
          Holidays.routeName: (context) => Holidays(),
          Settings.routeName: (context) => Settings(),
          BottomNavBar.routeName: (context) => BottomNavBar(),
        },
        home: BottomNavBar(),
      ),
    );
  }
}
