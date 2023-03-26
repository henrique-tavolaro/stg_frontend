import 'package:flutter/material.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final Color color;
  final Color? textColor;

  const CustomButton(
      {Key? key,
      required this.onClick,
      required this.text,
      required this.color, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onClick,
      child: Text(text).h5(style: TextStyle(color: textColor ?? Colors.white)),
    );
  }
}
