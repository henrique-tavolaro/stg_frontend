import 'package:flutter/material.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/core/utils/screen_size.dart';
import 'package:stg_frontend/presentation/pages/department_details/department_details_page.dart';

class CheckTreeCard extends StatelessWidget {
  const CheckTreeCard({
  super.key,
  required this.widget,
  });

  final DepartmentDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child:
      Container(
          padding: const EdgeInsets.all(20),
          width: screenSize(context).width,
          child: SizedBox(
            child: Row(
              children: [
                const Icon(Icons.account_tree),
                SizedBox(
                  width: screenSize(context).width / 20,
                ),
                Flexible(child: Text(
                  '${AppTexts.seeAllTasks}${widget.department}',
                  softWrap: true,).h3()),

              ],
            ),
          )),
    );
  }
}
