import 'dart:core';

import 'package:flutter/material.dart';
import 'package:Habo/app_pages/screenTimePage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:app_usage/app_usage.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'appUsagePage.dart';
import 'dart:typed_data';

class DonutChartWidget extends StatefulWidget {
  const DonutChartWidget({Key key}) : super(key: key);

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  List<AppUsageData> _chartData = [];
  num total_time = 0;
  String _formatTime;
  Uint8List icon;

  void chartDataCalculation() async {
    try {
      DateTime endTime = DateTime.now();
      num daySubtracter = endTime.hour;
      num minSubtracter = endTime.minute;
      num secSubtracter = endTime.second;
      DateTime startTime = endTime.subtract(
        Duration(
          hours: daySubtracter,
          minutes: minSubtracter,
          seconds: secSubtracter,
        ),
      );
      List<AppUsageInfo> _usedApps =
          await AppUsage.getAppUsage(startTime, endTime);
      List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);

      for (var app in apps) {
        for (var used in _usedApps) {
          if (app.packageName == used.packageName) {
            var item = AppUsageData(app.name, used.usage.inMinutes);
            _chartData.add(item);
            total_time += used.usage.inMinutes;
          }
        }
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
    _chartData.sort(
      (a, b) => b.usageTime.compareTo(a.usageTime),
    );
    if (_chartData.length > 4) {
      _chartData = _chartData.sublist(0, 4);
    }

    setState(() {});
  }

  List<AppUsageData> get getChartData {
    return _chartData;
  }

  @override
  void initState() {
    super.initState();
    chartDataCalculation();
    _chartData = getChartData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 235,
      child: Stack(
        children: [
          SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<AppUsageData, String>(
                cornerStyle: CornerStyle.bothCurve,
                dataSource: _chartData,
                xValueMapper: (AppUsageData data, _) => data.appName,
                yValueMapper: (AppUsageData data, _) => data.usageTime,
                radius: '80%',
                innerRadius: '81%',
                dataLabelMapper: (AppUsageData data, __) => data.appName,
                dataLabelSettings: const DataLabelSettings(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  isVisible: true,
                  labelIntersectAction: LabelIntersectAction.shift,
                  labelAlignment: ChartDataLabelAlignment.top,
                  connectorLineSettings: ConnectorLineSettings(
                    color: Colors.grey,
                    length: '5',
                    type: ConnectorType.curve,
                    width: 1,
                  ),
                  labelPosition: ChartDataLabelPosition.outside,
                ),
              )
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Today",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const screentimepage(),
                      ),
                    );
                  }),
                  child: Text(
                    timeFormatting(total_time),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int hr, min;
  String timeFormatting(num usageTime) {
    if (usageTime != 0) {
      hr = (usageTime ~/ 60);
      min = usageTime % 60;
      if (hr == 0 || min == 0) {
        if (hr == 0 && min != 1) {
          _formatTime = '$min mins';
        } else if (hr == 0 && min == 1) {
          _formatTime = '$min min';
        } else if (hr != 1 && min == 0) {
          _formatTime = '$hr hrs';
        } else if (hr == 1 && min == 0) {
          _formatTime = '$hr hr';
        } else {
          _formatTime = '<1 min';
        }
      } else {
        if (hr == 1) {
          _formatTime = '$hr hr $min mins';
        } else if (min == 1) {
          _formatTime = '$hr hrs $min min';
        } else {
          _formatTime = '$hr hrs $min mins';
        }
      }
    } else {
      _formatTime = "Less than one minute";
    }

    return _formatTime;
  }
}

class AppUsageData {
  String appName;
  int usageTime;

  AppUsageData(this.appName, this.usageTime);
}
