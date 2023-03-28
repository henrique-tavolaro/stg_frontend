import 'package:flutter/material.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog_textfield.dart';

class CustomFloatingActionButton extends StatelessWidget {

  final TextEditingController textEditingController;
  final VoidCallback onClick;
  final String dialogText;
  final String buttonText;


  const CustomFloatingActionButton

  ({
  super.key,
  required this.textEditingController,
  required this.onClick,
  required this.dialogText,
  required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return MyAlertDialogTextfield(
                controller: textEditingController,
                onClick: onClick,
                text: dialogText,
              );
            });
      },
      backgroundColor: AppColor.purple600,
      label: Text(buttonText),
      icon: const Icon(Icons.add),
    );
  }
}
