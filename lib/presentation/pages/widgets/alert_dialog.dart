
import 'package:flutter/material.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';

class MyAlertDialog extends StatefulWidget {

  final String text;
  final VoidCallback onClick;

  const MyAlertDialog({super.key, required this.onClick, required this.text});

  @override
  MyAlertDialogState createState() => MyAlertDialogState();
}


class MyAlertDialogState extends State<MyAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppTexts.cancel),
        ),
        ElevatedButton(
          onPressed: widget.onClick,
          child: const Text(AppTexts.confirm),
        ),
      ],
    );
  }
}