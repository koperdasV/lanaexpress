import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/loads/filter_dialog/filter_dialog.dart';
import 'package:lanaexpress/ui/loads/loads_viewmodel.dart';

class FilterLoadsButton extends StatelessWidget {
  final LoadsViewModel viewModel;
  const FilterLoadsButton({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FilterLoadsDialog(
              viewModel: viewModel,
            ),
          );
        },
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
          backgroundColor: const MaterialStatePropertyAll(btnFilter),
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
        child: Row(
          children: [
            Text(
              filter,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Gap(7),
            Image.asset(AssetsIcons.icFilter)
          ],
        ),
      ),
    );
  }
}
