import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/https.dart';

class ExamsCard extends StatefulWidget {
  final int index;
  ExamsCard({@required this.index});
  @override
  _ExamsCardState createState() => _ExamsCardState();
}

class _ExamsCardState extends State<ExamsCard> {
  var arrowBool = true;
  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<Https>(context, listen: false).examList[widget.index];
    return ExpansionTile(
      initiallyExpanded: true,
      onExpansionChanged: (expansionBool) {
        setState(() {
          arrowBool = expansionBool;
        });
      },
      trailing: Icon(
          arrowBool
              ? Icons.arrow_circle_up_outlined
              : Icons.arrow_drop_down_circle_outlined,
          color: Colors.black),
      title: Text(
        'Faculty: ' + data.faculty,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        'Department: ' + data.department,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
      children: [
        Text('Name: ' + data.name,
            style: const TextStyle(fontWeight: FontWeight.w800)),
          const  SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date: ' + DateFormat('dd-MM-yyyy').format(data.date),
                style: const TextStyle(fontWeight: FontWeight.w800)),
            Text('Time: ' + DateFormat('hh:mm aaa').format(data.date),
                style: const TextStyle(fontWeight: FontWeight.w800))
          ],
        ),
          const  SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Course: ' + data.course,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            Text('Course Code: ' + data.courseCode,
                style: const TextStyle(fontWeight: FontWeight.w800))
          ],
        ),
          const  SizedBox(height: 5),

      ],
    );
  }
}
