import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../icon/pin_icons.dart';
import '../../providers/notes.dart';

class TwoCards extends StatelessWidget {
  int firstItemIndex;
  int secondItemIndex;
  TwoCards({
    Key? key,
    required this.firstItemIndex,
    required this.secondItemIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesData = context.watch<Notes>();
    return Row(
      children: [
        SizedBox(
          width: 190,
          height: 140,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Text(notesData.items[firstItemIndex].text),
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
        SizedBox(
          width: 162,
          height: 140,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Text(notesData.items[secondItemIndex].text),
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
      ],
    );
  }
}
