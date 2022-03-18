import 'package:dart_test/history_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "History",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff80cbc4),
              ),
            ),
            SizedBox(height: 15),
            Align(child: HistoryChart())
          ],
        ),
      ),
    );
  }
}
