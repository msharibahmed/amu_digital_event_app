import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/bottom_sheet/bottom_sheet.dart';
import '../widgets/event_tabs.dart/happened_events.dart';
import '../widgets/event_tabs.dart/ongoing_events.dart';
import '../widgets/event_tabs.dart/upcoming_events.dart';
import '../widgets/event_card/filter_events.dart';
import '../providers/https.dart';

class Events extends StatefulWidget {
  static const routeName = 'event-screen';
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var _calendarController;
  @override
  void initState() {
    super.initState();

    // Provider.of<Https>(context, listen: false).getEvents();

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  var calendarSize = {
    CalendarFormat.month: 'Compact',
    CalendarFormat.week: 'Full Stretched'
  };

  @override
  Widget build(BuildContext context) {
    final eventsCalendarMarkers =
        Provider.of<Https>(context, listen: false).eventsCalendarMarker;
    final holidaysCalendarMarkers =
        Provider.of<Https>(context, listen: false).holidaysCalendarMarker;
    final sortEvent = Provider.of<Https>(context).sortEvent;
    // print(events);
    List<String> tabNames = const ['Upcoming', 'Ongoing', 'Happened'];

    TabBar _tabBar = TabBar(
        tabs: tabNames
            .map(
              (name) => Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
            .toList());

    var mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Filter Events'),
        icon: const Icon(Icons.sort),
        onPressed: () {
          showBarModalBottomSheet(
              context: context,
              builder: (context) => FilterEvents());
        },
      ),
      backgroundColor: Colors.indigo[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 30, bottom: 0),
              child: const Text(
                '   AMU Digital Events',
                style: const TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TableCalendar(
                        onDaySelected: (selectedDate, __, ___) {
                          showBarModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  EventBottomSheet(selectedDate: selectedDate));
                        },
                        initialCalendarFormat: CalendarFormat.month,
                        formatAnimation: FormatAnimation.scale,
                        availableCalendarFormats: calendarSize,
                        availableGestures: AvailableGestures.all,
                        calendarController: _calendarController,
                        events: eventsCalendarMarkers,
                        holidays: holidaysCalendarMarkers,
                        builders: CalendarBuilders(
                          holidayDayBuilder: (context, date, _) {
                            return ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 0.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 11.0, bottom: 0.0),
                                color: Color(0xff42dcff),
                                width: 38,
                                height: 38,
                                child: Text('${date.day}',
                                    style: TextStyle().copyWith(
                                        fontSize: 16.0, color: Colors.white)),
                              ),
                            );
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: mq.height * 0.72,
                            minHeight: mq.height * 0.2),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink[50],
                              ),
                              child: DefaultTabController(
                                child: Scaffold(
                                  backgroundColor: Colors.indigo[100],
                                  appBar: AppBar(
                                      centerTitle: false,
                                      title: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Events',
                                                style: const TextStyle(
                                                    letterSpacing: 2,
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              const Spacer(),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20,
                                                            top: 0,
                                                            bottom: 20),
                                                    child: Text(
                                                      'Sorted By: ' +
                                                          sortEvent,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                      backgroundColor: Colors.indigo[200],
                                      bottom: PreferredSize(
                                        child: _tabBar,
                                        preferredSize: Size.fromHeight(
                                          _tabBar.preferredSize.height - 50,
                                        ),
                                      )),
                                  body: TabBarView(children: [
                                    UpComingEvents(mq: mq),
                                    OngoingEvents(mq: mq),
                                    HappenedEvents(mq: mq),
                                  ]),
                                ),
                                length: 3,
                              )),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
