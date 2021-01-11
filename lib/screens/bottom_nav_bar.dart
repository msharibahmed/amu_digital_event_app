import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'exams.dart';
import 'home.dart';
import 'notices.dart';
import 'settings.dart';
import 'holidays.dart';
import '../providers/https.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = 'bottom-nav-bar-screen';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _loading = true;
  @override
  void initState() {
    super.initState();
    final prov = Provider.of<Https>(context, listen: false);

    prov
        .getEvents()
        .then((_) => prov.getHolidays())
        .then((_) => prov.getExams())
        .then((_) {
      setState(() {
        _loading = false;
      });
    });
  }

  var screens = {
    0: Home(),
    1: Holidays(),
    2: Notices(),
    3: Exams(),
    4: Settings()
  };
  var body = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: _loading
            ? AppBar(
                title: Text('Gathering Data, Please Wait....'),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              )
            : null,
        backgroundColor: _loading ? Colors.white : Colors.indigo[900],
        bottomNavigationBar: SizedBox(
          height: 53,
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                body = index;
              });
            },
            currentIndex: body,
            iconSize: 20,
            selectedFontSize: 15,
            // backgroundColor: Colors.indigoAccent,
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            unselectedFontSize: 15,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/events.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Events'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/holiday.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Holidays'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/notice.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Notices'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/exam.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Exam'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/settings.png',
                    fit: BoxFit.contain,
                    width: 23,
                    height: 23,
                  ),
                  label: 'Setting'),
            ],
          ),
        ),
        body: _loading
            ? FlareActor(
                "assets/flares/wait.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: 'animation',
              )
            : screens[body],
      ),
    );
  }
}
