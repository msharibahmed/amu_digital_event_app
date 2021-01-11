import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../event_card.dart';
import '../../providers/https.dart';


class OngoingEvents extends StatelessWidget {
  const OngoingEvents({
    @required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context);
    return data.ongoingEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('No Ongoing Events!'),
                Image.network(
                  'https://www.clubr.in/images/no-events-1.png',
                  fit: BoxFit.contain,
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemBuilder: (context, index) => EventCard(
                index: index,
                data: data.ongoingEventList,
              ),
              itemCount: data.ongoingEventList.length,
            ),
          );
  }
}