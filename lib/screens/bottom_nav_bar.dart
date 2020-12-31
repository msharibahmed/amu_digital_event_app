import 'package:amui_digital_event_app/screens/notice.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'notice.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var screens = {0: Home(), 1: Notice()};
  var body = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,

        backgroundColor: Colors.indigo[900],
        //   title: Text('AMU Digital Event'),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 10,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      body = 0;
                    });
                  },
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(
                    Icons.accessible_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      body = 1;
                    });
                  },
                ),
                label: 'notice'),
          ],
        ),
        body: screens[body],
      ),
    );
  }
}
