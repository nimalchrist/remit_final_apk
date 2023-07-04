import 'package:Habo/helpers.dart';
import 'package:Habo/provider.dart';
import 'package:Habo/screens/onboarding_screen.dart';
import 'package:Habo/widgets/calendar_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (!Provider.of<Bloc>(context).getSeenOnboarding)
        ? OnBoardingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Build Your Habits",
                style: Theme.of(context).textTheme.headline5,
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.bar_chart,
                    semanticLabel: 'Statistics',
                  ),
                  color: Color.fromARGB(255, 10, 10, 10),
                  tooltip: 'Statistics',
                  onPressed: () {
                    Provider.of<Bloc>(context, listen: false).hideSnackBar();
                    navigateToStatisticsPage(context);
                  },
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.settings,
                //     semanticLabel: 'Settings',
                //   ),
                //   color: Color.fromARGB(255, 0, 0, 0),
                //   tooltip: 'Settings',
                //   onPressed: () {
                //     // Provider.of<Bloc>(context, listen: false).hideSnackBar();
                //     // navigateToSettingsPage(context);
                //   },
                // ),
              ],
            ),
            body: CalendarColumn(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Provider.of<Bloc>(context, listen: false).hideSnackBar();
                navigateToCreatePage(context);
              },
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                semanticLabel: 'Add',
                size: 35.0,
              ),
            ),
          );
  }
}
