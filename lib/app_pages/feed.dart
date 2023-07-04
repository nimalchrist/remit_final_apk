import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate a list of available hobbies here

  List data = [];
  List<Map> availableHobbies = [
    {"name": "Technology", "isChecked": false},
    {"name": "Music", "isChecked": false},
    {"name": "Coding", "isChecked": false},
    {"name": "Hiking", "isChecked": false},
    {"name": "Traveling", "isChecked": false},
    {"name": "Hacking", "isChecked": false},
    {"name": "Automobile", "isChecked": false},
    {"name": "Competitions", "isChecked": false},
    {"name": "Sports", "isChecked": false},
    {"name": "Art", "isChecked": false},
    {"name": "Books", "isChecked": false},
    {"name": "Surfing The Internet", "isChecked": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'You are interested in..',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            // The checkboxes will be here
            Column(
                children: availableHobbies.map((hobby) {
              return CheckboxListTile(
                  value: hobby["isChecked"],
                  title: Text(hobby["name"]),
                  onChanged: (newValue) {
                    setState(() {
                      hobby["isChecked"] = newValue;
                    });
                  });
            }).toList()),

            // Display the result here
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Wrap(
              children: availableHobbies.map((hobby) {
                if (hobby["isChecked"] == true) {
                  return Card(
                    elevation: 3,
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(hobby["name"]),
                    ),
                  );
                }

                return Container();
              }).toList(),
            )
          ]),
        ),
      ),
    );
  }
}
