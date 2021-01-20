import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/https.dart';

class EntranceCard extends StatefulWidget {
  final int index;
  EntranceCard({@required this.index});
  @override
  _EntranceCardState createState() => _EntranceCardState();
}

class _EntranceCardState extends State<EntranceCard> {
  var arrowBool = true;
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<Https>(context, listen: false).entranceList[widget.index];
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
        'Name: ' + data.name,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        'Course: ' + data.course,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date: ' + DateFormat('dd-MM-yyyy').format(data.date),
                style: const TextStyle(fontWeight: FontWeight.w800)),
            Text('Time: ' + DateFormat('hh:mm aaa').format(data.date),
                style: const TextStyle(fontWeight: FontWeight.w800))
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text(
              'source: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: GestureDetector(
                onTap: data.url == null
                    ? () {}
                    : () {
                        _launchURL(data.url);
                      },
                child: Text(
                  (data.url ?? 'Not Given'),
                  style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.w800,
                      color: data.url == null ? Colors.black : Colors.blue,
                      decoration:
                          data.url == null ? null : TextDecoration.underline),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
