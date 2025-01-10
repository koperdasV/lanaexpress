import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/utils/base_button.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.isAccept,
    this.isIcon,
  });

  final String title;
  final String subtitle;
  final bool? isAccept;
  final bool? isIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: AppBordersRadius.borderRadiusAllSSM,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: dark),
                ),
                isIcon ?? false
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Image.asset(AssetsIcons.greenTrackFill),
                      )
                    : const Offstage(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                isAccept ?? false
                    ? BaseButton(
                        width: 88,
                        height: 36,
                        title: accept,
                        onPressed: () {},
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: whiteColor),
                      )
                    : const Offstage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// List<NotificationItem> listNotification = [
//   const NotificationItem(
//     title: 'Bids',
//     subtitle: 'Your bet #1231232 has won',
//   ),
//   const NotificationItem(
//     title: 'Bids',
//     subtitle: 'Your bet #1231232 has won',
//   ),
//   const NotificationItem(
//     title: 'Bids',
//     subtitle: 'Your bet #1231232 has won',
//   ),
//   const NotificationItem(
//     title: 'Load #123455 was assigned',
//     subtitle: 'Please accept the load',
//     isAccept: true,
//     isIcon: true,
//   ),
// ];
