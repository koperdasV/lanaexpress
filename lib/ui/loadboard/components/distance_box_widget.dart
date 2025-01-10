import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';

class DistanceBoxWidget extends StatelessWidget {
  const DistanceBoxWidget({
    required this.color, required this.title, super.key,
    this.height = 25,
    this.width = 64,
    this.fontSize = 14,
  });
  final Color color;
  final String title;
  final double? height;
  final double? width;
  final double? fontSize;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.size6),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: AppBordersRadius.borderRadiusAll20,
          color: color,
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: fontSize,
                  color: whiteColor,
                ),
          ),
        ),
      ),
    );
  }
}