import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 4,
      height: 18,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Dot(),
          SizedBox(height: 3),
          _Dot(),
          SizedBox(height: 3),
          _Dot(),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: const ShapeDecoration(
        color: iconAdditionalColor,
        shape: OvalBorder(),
      ),
    );
  }
}
