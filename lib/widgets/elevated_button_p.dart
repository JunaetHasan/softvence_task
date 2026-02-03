import 'package:flutter/material.dart';
import 'package:task_assignment/utils/app_color.dart';

class ElevatedButtonE extends StatelessWidget {
  const ElevatedButtonE({
    super.key,
    required this.child,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 50,
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(left: 180, right: 180),
            backgroundColor: AppColor.buttonColor,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
