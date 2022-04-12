import 'package:flutter/material.dart';

import '../../icon/pin_icons.dart';

class SmallCard extends StatelessWidget {
  final currentItem;
  const SmallCard({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 162,
          height: 140,
          child: Card(
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
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
