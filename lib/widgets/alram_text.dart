import 'package:flutter/material.dart';

class AlramText extends StatelessWidget {
  const AlramText.AlarmText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Alarm',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}