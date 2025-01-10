import 'package:flutter/material.dart';

class TextItemPlaceDialog extends StatelessWidget {
  final String title;
  final String info;
  const TextItemPlaceDialog({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: Theme.of(context).textTheme.headlineSmall,
        children: [
          TextSpan(text: info, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}