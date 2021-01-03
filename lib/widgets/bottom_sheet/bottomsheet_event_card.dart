import 'package:flutter/material.dart';

class BottomSheetEventCard extends StatelessWidget {
  final int index;
  BottomSheetEventCard({@required this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          width: 222,
          decoration: BoxDecoration(
            color: Colors.white,
            // boxShadow: [BoxShadow(spreadRadius: 5,blurRadius: 5,offset: Offset.infinite,color: Colors.amber)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 3,
                color: Colors.green,
                child: SizedBox(
                  width: 222,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        'Power System class',
                        overflow: TextOverflow.fade,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/' + 'add_reminder.png',
                      width: 18,
                      height: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 0, bottom: 2),
                child: Text('Time: ' + '4pm-6pm',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 4, bottom: 0),
                child: Text('Mode: ' + 'Online',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Padding(
//       padding: const EdgeInsets.all(
//         6.0,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [BoxShadow()],
//           ),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 width: 4,
//                 color: Colors.green,
//                 child: SizedBox(
//                   width: 4,
//                   height: 60,
//                 ),
//               ),
//               SizedBox(
//                 width: 6,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 4.0, top: 4, bottom: 2),
//                         child: Text(
//                           'Power System Conference',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Image.asset(
//                           'assets/icons/' + 'add_reminder.png',
//                           width: 25,
//                           height: 25,
//                         ),
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 4.0, top: 4, bottom: 2),
//                     child: Text('Time: ' + '4pm-6pm',
//                         style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.grey)),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 4.0, top: 4, bottom: 4),
//                     child: Text('Mode: ' + 'Online',
//                         style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.grey)),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     )
