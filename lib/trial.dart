import 'package:flutter/material.dart';

class TrialScreen extends StatefulWidget {
  const TrialScreen({super.key});

  @override
  _TrialScreenState createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('You have 4 new notifications',
                  style: TextStyle(), textAlign: TextAlign.center),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
