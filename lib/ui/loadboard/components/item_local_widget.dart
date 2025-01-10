import 'package:flutter/material.dart';

class ItemLocalWidget extends StatelessWidget {
  const ItemLocalWidget({
    required this.city, required this.date, required this.icon, super.key, this.width = 250, this.paddingLeft = 6,
  });
  final String city;
  final String date;
  final String icon;
  final double? width;
  final double paddingLeft;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            icon,
          ),
          Padding(
            padding: EdgeInsets.only(left: paddingLeft),
            child: SizedBox(
              width: width,
              height: 45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      city,
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 16,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
