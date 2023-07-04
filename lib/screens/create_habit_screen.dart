import 'package:Habo/provider.dart';
import 'package:Habo/widgets/text_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateHabitScreen extends StatefulWidget {
  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController cue = TextEditingController();
  TextEditingController routine = TextEditingController();
  TextEditingController reward = TextEditingController();
  TimeOfDay notTime = TimeOfDay(hour: 12, minute: 0);
  bool twoDayRule = false;
  bool showReward = false;
  bool advanced = false;
  bool notification = false;

  Future<void> setNotificationTime(context) async {
    TimeOfDay selectedTime;
    TimeOfDay initialTime = notTime;
    selectedTime = await showTimePicker(
        context: context,
        initialTime: (initialTime != null)
            ? initialTime
            : TimeOfDay(hour: 20, minute: 0));
    if (selectedTime != null) {
      setState(
        () {
          notTime = selectedTime;
        },
      );
    }
  }

  @override
  void dispose() {
    title.dispose();
    cue.dispose();
    routine.dispose();
    reward.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a Habit to build',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () {
            if (title.text.length != 0) {
              Provider.of<Bloc>(context, listen: false).addHabit(
                  title.text.toString(),
                  twoDayRule,
                  cue.text.toString(),
                  routine.text.toString(),
                  reward.text.toString(),
                  showReward,
                  advanced,
                  notification,
                  notTime);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  behavior: SnackBarBehavior.floating,
                  content: Text("The habit title can not be empty."),
                ),
              );
            }
          },
          child: Icon(
            Icons.check,
            semanticLabel: 'Save',
            color: Colors.white,
            size: 35.0,
          ),
        );
      }),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  TextContainer(
                    title: title,
                    hint: 'eg.: Exercise',
                    label: 'Habit',
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          onChanged: (bool value) {
                            setState(
                              () {
                                twoDayRule = value;
                              },
                            );
                          },
                          value: twoDayRule,
                        ),
                        Text("Use Two day rule"),
                        Tooltip(
                          message:
                              "With two day rule, you can miss one day and do not lose a streak if the next day is successful.",
                          child: Icon(
                            Icons.info,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          "Advanced habit building",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onExpansionChanged: (bool value) {
                        advanced = value;
                      },
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              "This section helps you better define your habits. You should remind yourself about the task, routine, and reward for every habit.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TextContainer(
                          title: cue,
                          hint: 'e.g. Remember the reason why u have started',
                          label: 'Description',
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                          title: Text("Notifications"),
                          trailing: Switch(
                            value: notification,
                            onChanged: (value) {
                              notification = value;
                              setState(() {});
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                          enabled: notification,
                          title: Text("Notification time"),
                          trailing: InkWell(
                            onTap: () {
                              if (notification) {
                                setNotificationTime(context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                notTime.hour.toString().padLeft(2, '0') +
                                    ":" +
                                    notTime.minute.toString().padLeft(2, '0'),
                                style: TextStyle(
                                    color: (notification)
                                        ? null
                                        : Theme.of(context).disabledColor),
                              ),
                            ),
                          ),
                        ),
                        // TextContainer(
                        //   title: routine,
                        //   hint: 'e.g. Do 50 push ups',
                        //   label: 'Routine',
                        // ),
                        TextContainer(
                          title: reward,
                          hint: 'e.g. 15 min. of video games',
                          label: 'Reward',
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (bool value) {
                                  setState(
                                    () {
                                      showReward = value;
                                    },
                                  );
                                },
                                value: showReward,
                              ),
                              Text("Show reward"),
                              Tooltip(
                                child: Icon(
                                  Icons.info,
                                  semanticLabel: 'Tooltip',
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                message:
                                    "The remainder of the reward after a successful routine.",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
