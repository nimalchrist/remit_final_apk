import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Series {
  final String year;
  final int subscribers;
  final charts.Color barcolor;

  Series({this.year, this.subscribers, this.barcolor});
}

class graphRepresentation extends StatefulWidget {
  const graphRepresentation({Key key}) : super(key: key);

  @override
  State<graphRepresentation> createState() => _graphRepresentationState();
}

class _graphRepresentationState extends State<graphRepresentation> {
  final List<Series> data = [
    // //Series(
    //     year: "2008",
    //     subscribers: 2000,
    //     barcolor: charts.ColorUtil.fromDartColor(Colors.blue)),
    Series(
      year: "MON",
      subscribers: 7,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
    Series(
      year: "TUE",
      subscribers: 4,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
    Series(
      year: "WED",
      subscribers: 11,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
    Series(
      year: "THU",
      subscribers: 14,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
    Series(
      year: "FRI",
      subscribers: 10,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
    Series(
      year: "SAT",
      subscribers: 20,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
    Series(
      year: "SUN",
      subscribers: 17,
      barcolor: charts.ColorUtil.fromDartColor(
        const Color.fromRGBO(130, 113, 237, 1),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Series, String>> series = [
      charts.Series(
          id: "Subscribers",
          //we have different methods to represent the data,like
          //DOMAIN function,MEASUREMENT function and COLOR function
          data: data,
          domainFn: (Series series, _) => series.year,
          measureFn: (Series series, _) => series.subscribers,
          colorFn: (Series series, _) => series.barcolor)
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: Container(
        height: 270,
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.BarChart(
                  series,
                  animate: true,
                  defaultRenderer: charts.BarRendererConfig(
                      cornerStrategy: const charts.ConstCornerStrategy(5)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
