import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';

class BaseOutlinedButton extends StatelessWidget {
  const BaseOutlinedButton({
    required this.title,
    required this.onPressed,
    this.height = 46,
    super.key,
  });
  final String title;
  final VoidCallback onPressed;
  final double? height;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry?>(
            EdgeInsets.all(AppSizes.sizeSSM),
          ),
          backgroundColor: const MaterialStatePropertyAll<Color?>(btnFilter),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: AppBordersRadius.borderRadiusAllS,
              side: BorderSide(
                color: mainPrimaryColor,
                width: 15,
              ),
            ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: mainPrimaryColor,
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
