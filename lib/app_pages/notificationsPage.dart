import 'remitAppBar.dart';
import 'BarGraphs.dart';
import 'package:flutter/material.dart';
import 'bottomdrawer.dart';

class notificationpage extends StatefulWidget {
  const notificationpage({Key key}) : super(key: key);

  @override
  State<notificationpage> createState() => _notificationState();
}

class _notificationState extends State<notificationpage> {
  List<String> items = ['Daily', 'Weekly', 'Monthly'];
  String selectedItem = 'Weekly';

  get notification => 789;

  get diffnoti => 290;

  get wordings => ' more than yesterday';

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const remitAppBar(),
      //main body of column
      body: Stack(
        children: [
          Column(
            children: [
              //first column with 2 rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1 container for icon
                  Container(
                      padding: const EdgeInsets.only(top: 29),
                      child: Icon(
                        Icons.notifications_active,
                      )),
                  //2 container for text
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: const Text(
                      ' Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'inter',
                      ),
                    ),
                  ),
                ],
              ), //first column ended

              //2nd column with two rows
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                      ),
                      //1st row with 2 columns
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 125),
                            child: Row(children: [
                              Text(
                                "$notification",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(" Notifications",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 85),
                            child: Row(
                              children: [
                                Text(
                                  "$diffnoti",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 119, 118, 118),
                                      fontSize: 15.0),
                                ),
                                Text(
                                  "$wordings",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 119, 118, 118),
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //2nd row ..dropdwn button
                      Container(
                        height: 28,
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                                color: Color.fromARGB(255, 0, 0, 0),
                                style: BorderStyle.solid,
                                width: 1.2)),
                        child: DropdownButton<String>(
                          value: selectedItem,
                          items: items
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) =>
                              setState(() => selectedItem = item),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: const graphRepresentation(),
              ),
            ],
          ),
          const BottomDrawerWidget(),
        ],
      ),
    );
  }
}
