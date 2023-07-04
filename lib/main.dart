import 'package:Habo/provider.dart';
import 'package:Habo/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Habo/app_pages/dashBoardPage.dart';
import 'app_pages/db_model/db_helper.dart';
import 'app_pages/db_model/table_timer.dart';
import 'package:system_alert_window/system_alert_window.dart';

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:app_usage/app_usage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Habo(),
    ),
  );
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  return true;
}

// void overlayWindow() {
//   SystemAlertWindow.showSystemWindow(
//     header: SystemWindowHeader(
//       padding: SystemWindowPadding(left: 20, top: 100, bottom: 100),
//       decoration: SystemWindowDecoration(
//           startColor: Color.fromARGB(255, 255, 253, 253),
//           endColor: Colors.blueGrey),
//       title: SystemWindowText(
//           text:
//               "Usage Limit his reached !Its time to roll into the real world.",
//           textColor: Color.fromARGB(255, 0, 0, 0),
//           fontSize: 15),
//       subTitle: SystemWindowText(text: "", textColor: Colors.white),
//     ),
//     body: SystemWindowBody(
//       decoration: SystemWindowDecoration(
//           startColor: Color.fromARGB(255, 243, 240, 240),
//           endColor: Color.fromARGB(255, 172, 222, 247)),
//       padding: SystemWindowPadding(left: 20),
//       rows: [
//         EachRow(
//           columns: [
//             EachColumn(
//               text: SystemWindowText(text: "Cycling", textColor: Colors.white),
//             ),
//             EachColumn(
//               text: SystemWindowText(text: "Cycling", textColor: Colors.white),
//             ),
//             EachColumn(
//               text: SystemWindowText(text: "Cycling", textColor: Colors.white),
//             )
//           ],
//         ),
//       ],
//     ),
//     footer: SystemWindowFooter(
//       buttons: [
//         SystemWindowButton(
//           text: SystemWindowText(text: 'close'),
//           tag: "close",
//         ),
//       ],
//       decoration: SystemWindowDecoration(
//         startColor: Colors.blue,
//       ),
//     ),
//     height: 400,
//   );
// }

void callBack(String tag) {
  if (tag == 'close') {
    SystemAlertWindow.closeSystemWindow();
  }
}

List<AppModel> items = [];
List<AppModel> foundedApps = [];

//fetching the limits from the data base and
void fetchAppLimits() async {
  //fetch logic
  var dbHelper = db_helper();
  List<limitTimer> fetchedApps = await dbHelper.getLimit();
  for (var i = 0; i < fetchedApps.length; i++) {
    var item = AppModel(fetchedApps[i].appName, fetchedApps[i].limitTime);
    items.add(item);
  }

  //app usage logic
  DateTime ending = DateTime.now();
  int daySubtracter = ending.hour;
  int minSubtracter = ending.minute;
  int secSubtracter = ending.second;
  DateTime starting = ending.subtract(
    Duration(
      hours: daySubtracter,
      minutes: minSubtracter,
      seconds: secSubtracter,
    ),
  );
  List<AppUsageInfo> apps = await AppUsage.getAppUsage(starting, ending);
  print("Length of limits: ${items.length}");

  for (var app in apps) {
    for (var item in items) {
      // print('${app.appName} + ${app.usage.inMinutes}');
    }
  }
}
// void getUsageStats() async {
//   try {
//     DateTime ending = DateTime.now();
//     int daySubtracter = ending.hour;
//     int minSubtracter = ending.minute;
//     int secSubtracter = ending.second;
//     DateTime starting = ending.subtract(
//       Duration(
//         hours: daySubtracter,
//         minutes: minSubtracter,
//         seconds: secSubtracter,
//       ),
//     );
//     print(starting);
//     print(ending);
//     List<AppUsageInfo> apps = await AppUsage.getAppUsage(starting, ending);
//     for (var app in apps) {
//       print('${app.appName} + ${app.usage.inSeconds}');
//       if (app.appName == item.name) {
//         if ((item.usage - app.usage.inSeconds) < 10) {
//           print("Time's up");
//         } else {
//           print("Remaining seconds: ${item.usage - app.usage.inSeconds}");
//         }
//       }
//     }
//   } on AppUsageException catch (exception) {
//     print(exception);
//   }
// }

void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
  if (service is AndroidServiceInstance) {
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  // bring to background
  Timer.periodic(
    const Duration(seconds: 20),
    (timer) async {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "REMIT application is running",
          content: "Timer running",
        );
      }

      //external plugin for background
      if (Platform.isAndroid) {
        fetchAppLimits();
      }
    },
  );
}

class Habo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bloc()),
      ],
      child: Consumer<Bloc>(
        builder: (context, counter, _) {
          final bloc = Provider.of<Bloc>(context);
          return MaterialApp(
            scaffoldMessengerKey: Provider.of<Bloc>(context).getScaffoldKey,
            theme: Provider.of<Bloc>(context).getSettings.getLight,
            // darkTheme: Provider.of<Bloc>(context).getSettings.getDark,
            home: !bloc.getDataLoaded ? LoadingScreen() : MyApp(),
          );
        },
      ),
    );
  }
}

class AppModel {
  String name;
  int usage;
  AppModel(this.name, this.usage);

  get limitTime => this.usage;

  Object get appName => this.name;
}
