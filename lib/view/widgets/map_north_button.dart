import 'package:flutter/material.dart';

class MapNorthButton extends StatelessWidget {
  final Function event;
  const MapNorthButton({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      // set button size
      size: const Size(44, 44),
      child: ClipOval(
        // make button shape circle
        child: Material(
          color: Theme.of(context).colorScheme.secondary,
          child: InkWell(
            onTap: () {
              event();
            },
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.navigation_outlined,
                  size: 18,
                  color: Colors.white,
                ), // icon
                Text(
                  'N',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
