import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final int index;
  EventCard({this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
        // color: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.only(left: 12, top: 0, bottom: 20, right: 12),
        elevation: 5,
        child: ListTile(
            title: Text('Ram Panchnami'),
            subtitle: Text('5 days Holiday'),
            onTap: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            trailing: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            leading:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                index.toString(),
                style: TextStyle(fontSize: 40),
              ),
              Text('Thu')
            ])));
  }
}
