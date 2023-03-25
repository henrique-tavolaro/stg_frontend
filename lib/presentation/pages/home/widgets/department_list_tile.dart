import 'package:flutter/material.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';

class DepartmentListTile extends StatelessWidget {
  final String title;
  final int index;
  final VoidCallback onClick;

  const DepartmentListTile(
      {Key? key, required this.title, required this.onClick, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4,
        child: ListTile(
          leading: Container(
            width: 20,
            color: setColor(index),
          ),
          contentPadding: const EdgeInsets.only(left: 0),
          onTap: onClick,
          title: Text(title).h3(),
        ),
      ),
    );
  }

  Color setColor(int index){
    if(index % 4 == 1) {
      return AppColor.purple600;
    }
    if(index % 4 == 2) {
      return AppColor.red500;
    }
    if(index % 4 == 3) {
      return AppColor.yellow500;
    }
    if(index % 4 == 4) {
      return AppColor.grey900;
    }
    return AppColor.green600;

  }

}
