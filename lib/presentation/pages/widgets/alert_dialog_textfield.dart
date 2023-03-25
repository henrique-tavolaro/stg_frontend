import 'package:flutter/material.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/presentation/cubit/department_list/department_list_cubit.dart';

class MyAlertDialogTextfield extends StatefulWidget {

  final String text;
  final VoidCallback onClick;
  final TextEditingController controller;

  const MyAlertDialogTextfield({super.key, required this.onClick, required this.controller, required this.text});

  @override
  MyAlertDialogTextfieldState createState() => MyAlertDialogTextfieldState();
}


class MyAlertDialogTextfieldState extends State<MyAlertDialogTextfield> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.text),
      content: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(hintText: AppTexts.typeHere),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppTexts.cancel),
        ),
        ElevatedButton(
          onPressed: widget.onClick,
          child: const Text(AppTexts.register),
        ),
      ],
    );
  }
}