import 'package:flutter/material.dart';

import '../../icon/pin_icons.dart';

class LargeCard extends StatelessWidget {
  final currentItem;
  const LargeCard({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Text(currentItem.text),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PinIcons.my_pin_outlined,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
