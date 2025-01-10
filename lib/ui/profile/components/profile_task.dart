import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/utils/base_button.dart';

class ProfileTask extends StatelessWidget {
  const ProfileTask({
    super.key,
    required this.task,
    required this.textButton,
    required this.title,
    required this.subtitle,
    this.widthBtn = 130,
    this.color, required this.onPressed,
  });
  final String task;
  final String textButton;
  final String title;
  final String subtitle;
  final double? widthBtn;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: backgroundLight,
          borderRadius: AppBordersRadius.borderRadiusAllSSM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 18),
                  ),
                  BaseButton(
                    onPressed: onPressed,
                    title: textButton,
                    width: widthBtn,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: whiteColor,
                          fontSize: 18,
                        ),
                    color: color,
                  )
                ],
              ),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: dark),
            ),
            const Gap(8),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
