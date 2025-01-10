import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    required this.image,
    required this.title,
    required this.info,
    super.key,
    this.subtitle,
  });
  final String image;
  final String title;
  final String? subtitle;
  final String info;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(image),
          const Gap(51),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            subtitle ?? '',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              info,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
