import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/https.dart';

class NoticeCard extends StatefulWidget {
  final int index;
  NoticeCard({@required this.index});
  @override
  _NoticeCardState createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
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
        Provider.of<Https>(context, listen: false).noticeList[widget.index];
    return Card(
        margin: const EdgeInsets.all(16),
        elevation: 5,
        shadowColor: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ' + data.name,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Start Date: ' +
                          DateFormat('dd-MM-yyyy').format(data.startDate),
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(
                      'Start Time: ' +
                          DateFormat('hh:mm aaa').format(data.startDate),
                      style: const TextStyle(fontWeight: FontWeight.w800))
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'End Date: ' +
                          DateFormat('dd-MM-yyyy').format(data.endDate),
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(
                      'End Time: ' +
                          DateFormat('hh:mm aaa').format(data.endDate),
                      style: const TextStyle(fontWeight: FontWeight.w800))
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'source: ',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
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
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color:
                                data.url == null ? Colors.black : Colors.blue,
                            decoration: data.url == null
                                ? null
                                : TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
