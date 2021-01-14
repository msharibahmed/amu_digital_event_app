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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('No Upcoming Events!'),
                  Image.network(
                    'https://www.clubr.in/images/no-events-1.png',
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
