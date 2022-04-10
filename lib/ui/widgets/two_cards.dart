import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../icon/pin_icons.dart';
import '../../providers/notes.dart';

class TwoCards extends StatelessWidget {
  int index;
  TwoCards({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesData = context.watch<Notes>();
    final allShortItem = notesData.shortItem();
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
                Text(allShortItem.elementAt(index).text),
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
                Text(allShortItem.elementAt(index + 1).text),
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
