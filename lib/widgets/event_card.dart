import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final int index;
  EventCard({this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
        elevation: 5,
        child: ListTile(
            title: Text('Ram Panchnami'),
            subtitle: Text('5 days Holiday'),
            onTap: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            trailing: IconButton(
              icon: Icon(Icons.notifications,color: Colors.black,),
              onPressed: () {},
            ),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                index.toString(),
                style: TextStyle(fontSize: 40),
              ),
              Text('Thu')
            ])));
  }
}
