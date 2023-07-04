import 'remitAppBar.dart';
import 'BarGraphs.dart';
import 'package:flutter/material.dart';
import 'bottomdrawer.dart';

class screentimepage extends StatefulWidget {
  const screentimepage({Key key}) : super(key: key);

  @override
  State<screentimepage> createState() => _screentimepageState();
}

class _screentimepageState extends State<screentimepage> {
  List<String> items = ['Daily', 'Weekly', 'Monthly'];
  String selectedItem = 'Daily';

  get time => null;

  get change_time => null;

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
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  //2 container for text
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: const Text(
                      ' Screen Time',
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
                          Container(
                            padding: const EdgeInsets.only(right: 190),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '$time ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 75),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '$change_time more than yesterday',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'inter',
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      //2nd row ..dropdwn button
                      Container(
                        height: 28,
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        alignment: AlignmentDirectional.center,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: StadiumBorder(
                            side: BorderSide(width: 2, color: Colors.black45),
                          ),
                        ),
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
                                        fontWeight: FontWeight.w500),
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
