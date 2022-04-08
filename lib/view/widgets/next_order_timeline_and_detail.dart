import 'package:flutter/material.dart';

class NextOrderTimelineAndDetail extends StatelessWidget {
  final String destinationName;
  final String orderTitle;

  const NextOrderTimelineAndDetail(
      {Key? key, required this.destinationName, required this.orderTitle})
      : super(key: key);

  Widget line(int widthFlex, Color color, Widget? extraWidget) {
    Widget container = Container(
      color: color,
      height: 2.5,
    );

    return Expanded(
      flex: widthFlex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: extraWidget == null
            ? container
            : Column(
                children: [
                  extraWidget,
                  container,
                ],
              ),
      ),
    );
  }

  Widget get details {
    return Column(
      children: [
        FittedBox(
          child: Text(
            destinationName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            orderTitle,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0, top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          line(2, Theme.of(context).colorScheme.primary, null),
          Column(
            children: [
              Icon(
                Icons.location_pin,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Icon(
                Icons.adjust,
                size: 12,
              ),
            ],
          ),
          line(
            5,
            Theme.of(context).colorScheme.secondary,
            details,
          ),
          Column(
            children: [
              Icon(
                Icons.location_pin,
                size: 34,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const Icon(
                Icons.adjust,
                size: 12,
              ),
            ],
          ),
          line(3, Colors.black26, null),
          Column(
            children: const [
              Icon(
                Icons.location_pin,
                size: 18,
                color: Colors.black87,
              ),
              Icon(
                Icons.adjust,
                size: 12,
              ),
            ],
          ),
          line(2, Colors.black26, null),
        ],
      ),
    );
  }
}
