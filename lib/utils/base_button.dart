import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';

class BaseButton extends StatelessWidget {

  const BaseButton({
    this.title,
    this.onPressed,
    super.key,
    this.height = 52,
    this.width = double.infinity,
    this.style = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: whiteColor,
      letterSpacing: -0.25,
    ),
    this.color = mainPrimaryColor,
  });
  final String? title;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: AppBordersRadius.borderRadiusAllS,
        ),
        padding: EdgeInsets.zero,
        child: Text(
          title ?? '',
          style: style,
        ),
      ),
    );
  }
}
