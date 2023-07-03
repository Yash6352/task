import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/utils/colorutils.dart';
import 'package:task_project/utils/font_utils.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar(this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Customize your AppBar here
      title: Text(
        title,
        style:
            FontUtils.medium.copyWith(fontSize: 15.sp, color: ColorUtils.white),
      ),
      backgroundColor: ColorUtils.blueF2,
      elevation: 0,
      // Add any additional properties you need
    );
  }
}
