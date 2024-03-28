import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreetingWidget extends StatelessWidget {

  const GreetingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('h:mm a').format(now);

    String greeting;
    if (now.hour < 12) {
      greeting = "Good Morning";
    } else if (now.hour < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Night";
    }

    return Text(
      '$greeting! It is $formattedTime.',
      style: TextStyle(fontSize: 20.0),
    );
  }
}