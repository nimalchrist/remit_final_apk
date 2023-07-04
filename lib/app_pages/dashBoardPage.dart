import 'package:flutter/material.dart';
import 'package:Habo/app_pages/bottomDrawer.dart';
import 'package:Habo/app_pages/unlocksPage.dart';
import 'package:Habo/app_pages/notificationsPage.dart';
import 'package:Habo/screens/home_screen.dart';
import 'remitAppBar.dart';
import 'donutChart.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remit DashBoard',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(251, 245, 245, 245),
      appBar: const remitAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.account_box),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const DonutChartWidget(),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 4,
                shadowColor: Colors.black,
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.task_rounded),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 55,
                                // child: const Text(
                                //   "34",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ),
                              Container(
                                child: const Text(
                                  "Build Your Habits",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) =>
                      //                 const notificationpage(),
                      //           ),
                      //         );
                      //       },
                      //       icon: const Icon(Icons.notifications_active_sharp),
                      //     ),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     Column(
                      //       children: [
                      //         Container(
                      //           width: 79,
                      //           child: const Text(
                      //             "789",
                      //             style: TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ),
                      //         Container(
                      //           child: const Text(
                      //             "Notifications",
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w500,
                      //               color: Colors.black26,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const BottomDrawerWidget(),
        ],
      ),
    );
  }
}
