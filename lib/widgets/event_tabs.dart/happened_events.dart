import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/https.dart';
import '../event_card.dart';


class HappenedEvents extends StatelessWidget {
  const HappenedEvents({
    @required this.mq,
  });

  final Size mq;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context);
    return data.happenedEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('No Happened Events!'),
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
                data: data.happenedEventList,
              ),
              itemCount: data.happenedEventList.length,
            ),
          );
  }
}

