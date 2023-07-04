import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'BarGraphs.dart';
import 'remitAppBar.dart';
import 'dart:typed_data';

class AppsUsage extends StatefulWidget {
  final Uint8List icon;
  String total_time;

  AppsUsage({Key key, this.icon, this.total_time}) : super(key: key);

  @override
  State<AppsUsage> createState() => _AppsUsageState(
        icon: icon,
        total_time: total_time,
      );
}

class _AppsUsageState extends State<AppsUsage> {
  var status = null;
  String total_time;
  var num_unlock = null;
  var num_notific = null;
  Uint8List icon;

  _AppsUsageState({this.icon, this.total_time});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const remitAppBar(),
      //main body of column
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //1.icon
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Image.memory(icon),
                            ),
                            const Text(
                              "Total Screen Time",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'inter',
                              ),
                            ),
                            Text(
                              '$total_time',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'inter',
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              //2 colum graph
              Column(
                children: [
                  Container(
                    child: const graphRepresentation(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SizedBox(
              height: 90,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              'lib/ui_design/assets/lock_open_FILL1_wght500_GRAD200_opsz48.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$num_unlock',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'inter',
                                  ),
                                ),
                                const Text(
                                  'Opened',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontFamily: 'inter'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 96),
                      child: Row(
                        children: [
                          Container(
                            child:
                                const Icon(Icons.notifications_active_rounded),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$num_unlock',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'inter'),
                                ),
                                const Text(
                                  'Notification',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontFamily: 'inter'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SizedBox(
              height: 90,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueAccent[100],
                            ),
                            child: Icon(Icons.timer_rounded, size: 24),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 24, left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'App Timer',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 96),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 16, left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$status',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontFamily: 'Inter'),
                                ),
                                const Text(
                                  'Add Timer',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
