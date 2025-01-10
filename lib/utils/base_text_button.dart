import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/main/main_mobile.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MainMobile(
              ),
            ),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: AppBordersRadius.borderRadiusAllS,
            ),
          ),
        ),
        child: Text(
          skip,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
