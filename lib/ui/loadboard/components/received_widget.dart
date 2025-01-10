import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_screen.dart';
import 'package:lanaexpress/utils/date_received.dart';

class ReceivedWidget extends StatelessWidget {
  const ReceivedWidget({
    required this.number,
    required this.loadboard,
    super.key,
  });
  final String number;
  final Loadboard loadboard;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Received:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${timePassedParse(loadboard.createdAt ?? '')} ago',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 13),
                ),
              ],
            ),
            const Gap(14),
            SizedBox(
              height: 40,
              width: 140,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: loadboard.driversList?.length,
                itemBuilder: (final BuildContext context, final int index) {
                  return DriverIdWidget(
                    iValue: loadboard.driversList?[index],
                  );
                },
              ),
            ),
          ],
        ),
        Text(
          number,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
