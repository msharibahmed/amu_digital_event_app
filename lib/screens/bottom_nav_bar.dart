import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'exams.dart';
import 'events.dart';
import 'notices.dart';
import 'entrances.dart';
import 'holidays.dart';
import 'settings_screen/settings.dart';
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
        .then((_) => prov.getEntrances())
        .then((_) => prov.getNotices())
        .then((_) {
      setState(() {
        _loading = false;
      });
    });
  }

  var screens = {
    0: Events(),
    1: Holidays(),
    2: Notices(),
    3: Entrances(),
    4: Exams(),
    5: Settings()
  };
  var body = 0;

  @override
  Widget build(BuildContext context) {
    // const bottomNavNames = [
    //   {'events': 'Events'},
    //   {'holiday': 'Holidays'},
    //   {'notice': 'Notices'},
    //   {'exam': 'Exams'},
    //   {'settings': 'Setting'}
    // ];
    var bottomNavNames = [
      {CupertinoIcons.calendar: 'Events'},
      {CupertinoIcons.star: 'Holidays'},
      {CupertinoIcons.bell: 'Notices'},
      {CupertinoIcons.news: 'Entrances'},
      {CupertinoIcons.book: 'Exams'},
      {CupertinoIcons.settings: 'Setting'}
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: _loading
            ? AppBar(
                title: const Text('Gathering Data, Please Wait....'),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              )
            : null,
        backgroundColor: _loading ? Colors.white : Colors.indigo[900],
        bottomNavigationBar: _loading
            ? null
            : SizedBox(
                height: 53,
                child: BottomNavigationBar(
                    elevation: 0,
                    onTap: (index) {
                      setState(() {
                        body = index;
                      });
                    },
                    currentIndex: body,
                    iconSize: 20,
                    selectedFontSize: 15,
                    selectedIconTheme: IconThemeData(color: Colors.indigo[800]),
                    selectedItemColor: Colors.indigo,
                    unselectedItemColor: Colors.black,
                    showSelectedLabels: true,
                    unselectedFontSize: 15,
                    type: BottomNavigationBarType.shifting,
                    items: (bottomNavNames)
                        .map((iteration) => BottomNavigationBarItem(
                            icon: Icon(iteration.keys.toList()[0]),
                            // Image.asset(
                            //   'assets/icons/' + iteration.keys.toList()[0] + '.png',
                            //   fit: BoxFit.contain,
                            //   width: 23,
                            //   height: 23,
                            // ),
                            label: iteration.values.toList()[0]))
                        .toList())),
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
