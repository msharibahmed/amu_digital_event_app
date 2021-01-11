import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HolidayCard extends StatelessWidget {
  final int index;
  HolidayCard({this.index});
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context).holidayList;
    return Card(
        color: Colors.indigo[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.only(left: 12, top: 0, bottom: 20, right: 12),
        elevation: 5,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gradient:
                  LinearGradient(colors: [Color(0xFFEF9A), Color(0xFFEF9A9A)]),
            ),
            child: ExpansionTile(
              expandedAlignment: Alignment.bottomLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text(
                        'source: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Expanded(child:   GestureDetector(
                        onTap: data[index].url == null
                            ? () {}
                            : () {
                                _launchURL(data[index].url);
                              },
                        child: Text(
                            (data[index].url ?? 'Not Given'),
                            style: TextStyle(
                                fontSize: 18,
                                color: data[index].url == null
                                    ? Colors.black
                                    : Colors.blue,
                                decoration: data[index].url == null
                                    ? null
                                    : TextDecoration.underline),
                  
                        ),
                      ),)
                    
                    ],
                  ),
                ),
              ],
              title: Text(
                data[index].name,
                style: TextStyle(fontSize: 17, letterSpacing: 1),
              ),
              subtitle: Text(
                DateFormat('dd MMM').format(data[index].startDate) +
                    '-' +
                    DateFormat('dd MMM').format(data[index].endDate),
                style: TextStyle(color: Colors.grey[700]),
              ),
              leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd').format(data[index].startDate),
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(DateFormat('EEE').format(data[index].startDate))
                  ]),
            )));
  }
}
