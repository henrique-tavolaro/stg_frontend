import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final Color color;

  const CustomButton(
      {Key? key,
      required this.onClick,
      required this.text,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color),
      onPressed: onClick,
      child: Text(text),
    );
  }
}
