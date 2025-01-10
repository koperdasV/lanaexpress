import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';

class UploadPhotoWidget extends StatelessWidget {
  const UploadPhotoWidget({
    super.key,
    required this.onTap, this.subtitle,required this.title,
  });

  final VoidCallback onTap;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 232,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: AppBordersRadius.borderRadiusAllSSM,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsIcons.uploadPhoto),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: dark),
              ),
              Text(
                subtitle ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
