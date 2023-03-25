import 'package:flutter/material.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/presentation/cubit/department_list/department_list_cubit.dart';

class MyAlertDialog extends StatefulWidget {

  final VoidCallback onClick;
  final TextEditingController controller;

  const MyAlertDialog({super.key, required this.onClick, required this.controller});

  @override
  MyAlertDialogState createState() => MyAlertDialogState();
}


class MyAlertDialogState extends State<MyAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppTexts.areaRegister),
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