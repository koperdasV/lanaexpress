import 'package:flutter/material.dart';

import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/generated/router.gr.dart';
import 'package:lanaexpress/utils/base_button.dart';

final class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(AssetsIcons.checkmark),
            Column(
              children: <Widget>[
                Text(
                  'Success!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  'Your bid has been submitted.',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: grey,
                      ),
                ),
              ],
            ),
            BaseButton(
              title: 'Continue',
              onPressed: () {
                router.push(const MainMobile());
              },
            ),
          ],
        ),
      ),
    );
  }
}
