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
    final mediaQuerySize = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuerySize.width * 0.52,
      height: mediaQuerySize.height * 0.18,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        color: currentItem.color == 0
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.tertiary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentItem.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
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
    );
  }
}
