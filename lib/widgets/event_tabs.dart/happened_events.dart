import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/https.dart';
import '../../widgets/event_card/event_card.dart';

class HappenedEvents extends StatelessWidget {
  final Size mq;

  const HappenedEvents({
    @required this.mq,
  });

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context, listen: false);
    return data.happenedEventList.length == 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No Happened Events!'),
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
            padding: const EdgeInsets.only(top: 16),
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
