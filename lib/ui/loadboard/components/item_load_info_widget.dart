import 'package:flutter/material.dart';

class ItemLoadInfoWidget extends StatelessWidget {
  const ItemLoadInfoWidget({
    required this.title, required this.subtitle, super.key,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 27),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
