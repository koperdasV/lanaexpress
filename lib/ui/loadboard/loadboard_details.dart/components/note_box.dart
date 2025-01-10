import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';

class NoteBox extends StatelessWidget {
  final Loadboard? loadboard;
  const NoteBox({
    super.key,
    required this.loadboard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size30),
      child: Container(
        height: AppSizes.size50,
        padding: const EdgeInsets.fromLTRB(AppSizes.size20, AppSizes.sizeSSM, 0, AppSizes.sizeSSM),
        decoration: BoxDecoration(
          borderRadius: AppBordersRadius.borderRadiusAllXS,
          border: Border.all(
            color: noteBorder,
            width: 2,
          ),
          color: noteBackground,
        ),
        child: Text(
          'NOTE:  ${loadboard?.note ?? 'Absent'}',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(fontSize: 18, color: noteBorder),
        ),
      ),
    );
  }
}