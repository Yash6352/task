import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_project/utils/colorutils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.hintText,
      this.pIcon,
      this.sIcon,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.obscureText = false,
      this.hintStyle,
      this.keyBoardType,
      this.inputBorder,
      this.errorText,
      this.style,
      this.enable = false})
      : super(key: key);
  final String? hintText;
  final String? errorText;
  final Widget? pIcon;
  final Widget? sIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final bool? enable;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextInputType? keyBoardType;
  final InputBorder? inputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: style,
      keyboardType: keyBoardType,
      cursorColor: ColorUtils.black,
      inputFormatters: inputFormatters,
      obscureText: obscureText!,
      decoration: InputDecoration(
        hintText: hintText,

        ///height
        isDense: true,
        enabled: enable!,
        contentPadding: const EdgeInsets.all(8),

        ///
        hintStyle: hintStyle,
        helperText: '',
        prefixIcon: pIcon,
        suffixIcon: sIcon,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: ColorUtils.whiteE5),
        ),
        errorStyle: const TextStyle(height: 0),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: ColorUtils.whiteE5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: ColorUtils.whiteE5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: ColorUtils.whiteE5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: ColorUtils.whiteE5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: ColorUtils.whiteE5),
        ),
      ),
    );
  }
}
