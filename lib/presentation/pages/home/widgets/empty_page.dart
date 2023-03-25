import 'package:flutter/material.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/core/utils/screen_size.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenSize(context).height / 5,
        ),
        child: const Text(AppTexts.welcome).h3(),
      ),
      Center(
        child: const Text(AppTexts.startCreatingArea).h4(),
      ),
    ]);
  }
}
