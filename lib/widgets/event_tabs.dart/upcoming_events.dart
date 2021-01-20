import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/event_card/event_card.dart';
import '../../providers/https.dart';

class UpComingEvents extends StatelessWidget {
  final Size mq;

  const UpComingEvents({
    @required this.mq,
  });

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context, listen: false);
    return data.upcomingEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No Upcoming Events!'),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/events_empty.jpg',
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ))
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemBuilder: (context, index) => EventCard(
                index: index,
                data: data.upcomingEventList,
              ),
              itemCount: data.upcomingEventList.length,
            ),
          );
  }
}
