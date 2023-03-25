import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/core/utils/screen_size.dart';

class EmptyTaskPage extends StatelessWidget {
  const EmptyTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
        children: [

          Center(
            child: const Text(AppTexts.zeroTasks).h4(),
          ),
        ]);
  }
}
