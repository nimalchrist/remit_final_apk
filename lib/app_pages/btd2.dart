import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'dart:typed_data';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:app_usage/app_usage.dart';
import 'appUsagePage.dart';
import 'package:flutter/cupertino.dart';
import 'timer_utils.dart';

class BottomDrawerWidget extends StatefulWidget {
  const BottomDrawerWidget({Key key}) : super(key: key);

  @override
  State<BottomDrawerWidget> createState() => BottomDrawerWidgetState();
}

class BottomDrawerWidgetState extends State<BottomDrawerWidget> {
  final List<AppModel> _noUsedApps = [];
  List<AppModel> _finalApps = [];
  List<AppModel> _timedApps = [];
  List usageList = [];
  List apps = [];
  int totalScreenTime = 0;
  int hr = 0, min = 0;
  final double _headerHeight = 60.0;
  final double _bodyHeight = 360.0;
  final BottomDrawerController _controller = BottomDrawerController();
  int limitTime;

  void getStats() async {
    try {
      DateTime endTime = DateTime.now();

      int daySubtracter = endTime.hour;
      int minSubtracter = endTime.minute;
      int secSubtracter = endTime.second;
      DateTime startTime = endTime.subtract(
        Duration(
          hours: daySubtracter,
          minutes: minSubtracter,
          seconds: secSubtracter,
        ),
      );
      print(startTime);
      print(endTime);

      List<AppUsageInfo> usageList =
          await AppUsage.getAppUsage(startTime, endTime);
      List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);

      _finalApps = [];
      for (var app in apps) {
        for (var Usage in usageList) {
          if (app.packageName == Usage.packageName) {
            var item = AppModel(
              title: app.name,
              package: app.packageName,
              icon: app.icon,
              usagetime: Usage.usage.inMinutes,
            );
            _finalApps.add(item);
          } else {
            var item = AppModel(
              title: app.name,
              package: app.packageName,
              icon: app.icon,
              usagetime: Usage.usage.inMinutes,
            );
            _noUsedApps.add(item);
          }
        }
      }

      _finalApps.sort(
        (a, b) => b.usagetime.compareTo(a.usagetime),
      );

      for (var TTime in usageList) {
        totalScreenTime += TTime.usage.inMinutes;
      }

      print(totalScreenTime);
      print(DateTime.now().day);
      setState(() {});
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  List<AppModel> get getApps {
    return _finalApps;
  }

  Duration duration = const Duration(hours: 0, minutes: 0);

  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(duration.inHours);
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   //final seconds = twoDigits(duration.inSeconds.remainder(60));

  //   return '$hours hrs:$minutes mins';
  // }

  @override
  void initState() {
    super.initState();
    getStats();
  }

// declaration of the bottom drawer
  @override
  Widget build(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.white,
      controller: _controller,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          spreadRadius: 3,
          offset: Offset(5, -2), // changes position of shadow
        ),
      ],
    );
  }

// header section of the bottom drawer
  Widget _buildBottomDrawerHead(BuildContext context) {
    return Container(
      height: _headerHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(45)),
      ),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(
              left: 0.0,
              right: 160.0,
              top: 27.0,
            ),
            child: Text(
              "Most frequently used apps",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'inter'),
            ),
          ),
          Spacer(),
          Divider(
            height: 0.1,
            thickness: 4,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

// body section of the bottom drawer
  Widget _buildBottomDrawerBody(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _bodyHeight,
      child: _finalApps.isNotEmpty
          ? ListView.builder(
              itemCount: _finalApps.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int i) => Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: .1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppsUsage(
                              icon: _finalApps[i].icon,
                              total_time: _finalApps[i].getTimeFormat,
                            ),
                          ),
                        );
                      },
                      leading: Image.memory(_finalApps[i].icon),
                      title: Text(_finalApps[i].title),
                      subtitle: Text(_finalApps[i].getTimeFormat),
                      trailing: IconButton(
                        icon: !_finalApps[i].isSet
                            ? const Icon(
                                Icons.timer,
                                size: 35,
                              )
                            : const Icon(
                                Icons.check,
                              ),
                        onPressed: () => Utils.showSheet(
                          context,
                          child: buildTimePicker(),
                          onClicked: () {
                            setState(() {
                              limitTime = duration.inMinutes;
                              _finalApps[i].appLimit = limitTime;
                              _finalApps[i].isSet = true;
                              print(
                                  '${_finalApps[i].title}  ${_finalApps[i].appLimit}');
                              // Utils.showSnackBar(context, 'Selected "$value"');
                              // Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                      visualDensity: const VisualDensity(vertical: -3),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int i) => Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: .1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.error),
                      title: const Text("App title"),
                      subtitle: const Text("App usage time"),
                      trailing: IconButton(
                        icon: Container(
                          child: !_finalApps[i].isSet
                              ? const Icon(
                                  Icons.timer,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.check,
                                ),
                        ),
                        onPressed: () => Utils.showSheet(
                          context,
                          child: buildTimePicker(),
                          onClicked: () {
                            setState(() {
                              limitTime = duration.inMinutes;
                              _finalApps[i].appLimit = limitTime;
                              _finalApps[i].isSet = true;
                              print(
                                  '${_finalApps[i].title}  ${_finalApps[i].appLimit}');
                              // Utils.showSnackBar(context, 'Selected "$value"');
                              // Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                      visualDensity: const VisualDensity(vertical: -3),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoTimerPicker(
          initialTimerDuration: duration,
          mode: CupertinoTimerPickerMode.hm,
          minuteInterval: 5,
          secondInterval: 1,
          onTimerDurationChanged: (duration) =>
              setState(() => this.duration = duration),
        ),
      );
}

// appmodel class for structured data format
class AppModel {
  final String title;
  final String package;
  final Uint8List icon;
  final int usagetime;
  int appLimit;
  int hr = 0, min = 0;
  String _formatTime = "";
  bool isSet = false;

  AppModel({
    this.title,
    this.package,
    this.icon,
    this.usagetime,
  });

  String timeFormatting() {
    if (usagetime != 0) {
      hr = (usagetime ~/ 60);
      min = usagetime % 60;
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
      _formatTime = "<1 min";
    }

    return _formatTime;
  }

  //getters list
  int get getAppLimit {
    return appLimit;
  }

  String get getTimeFormat {
    return timeFormatting();
  }

  String get getAppName {
    return title;
  }

  String get getPackageName {
    return package;
  }
}
