import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/utils/colorutils.dart';

class FontUtils {
  static String RobotoFamily = 'Roboto';
  static TextStyle bold = TextStyle(
      fontFamily: RobotoFamily,
      fontSize: 10.sp,
      fontWeight: FontWeightClass.bold,
      color: ColorUtils.black);
  static TextStyle black = TextStyle(
      fontFamily: RobotoFamily,
      fontSize: 12.sp,
      fontWeight: FontWeightClass.black,
      color: ColorUtils.black);
  static TextStyle light = TextStyle(
      fontFamily: RobotoFamily,
      fontSize: 10.sp,
      fontWeight: FontWeightClass.light,
      color: ColorUtils.black);
  static TextStyle medium = TextStyle(
      fontFamily: RobotoFamily,
      fontSize: 10.sp,
      fontWeight: FontWeightClass.medium,
      color: ColorUtils.black);
  static TextStyle regular = TextStyle(
      fontFamily: RobotoFamily,
      fontSize: 10.sp,
      fontWeight: FontWeightClass.regular,
      color: ColorUtils.black);
}

class FontWeightClass {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiB = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraB = FontWeight.w800;
  static const black = FontWeight.w900;
}
