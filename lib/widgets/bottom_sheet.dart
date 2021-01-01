import 'package:flutter/material.dart';

class EventBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Text('Selected Day\'s Event'), Text('No Events!')],
      ),
    );
  }
}
