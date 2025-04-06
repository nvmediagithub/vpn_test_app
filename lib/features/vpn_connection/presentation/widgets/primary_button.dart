import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double borderRadius;
  final FontWeight? fontWeight;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
    this.borderRadius = 12.0,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Colors.white,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: TextStyle(
          fontSize: fontSize ?? 18.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
      child: Text(text),
    );
  }
}
