import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/note.dart';
import '../../icon/pin_icons.dart';

class NoteCard extends StatefulWidget {
  final Note currentItem;
  const NoteCard({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  void changePin() {
    print(widget.currentItem.pinned);
    setState(() {
      widget.currentItem.pinned = widget.currentItem.pinned;
    });
    print(widget.currentItem.pinned);
  }

  @override
  Widget build(BuildContext context) {
    Color colorCard = widget.currentItem.color == 1
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.tertiary;
    final mediaQuerySize = MediaQuery.of(context).size;
    return Container(
      width: mediaQuerySize.width * 0.4,
      height: mediaQuerySize.height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: colorCard,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset.fromDirection(1),
            color: colorCard,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: mediaQuerySize.width * 0.25,
                  height: mediaQuerySize.width * 0.1,
                  child: Text(
                    widget.currentItem.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                widget.currentItem.pinned
                    ? IconButton(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.topCenter,
                        onPressed: () => changePin,
                        icon: const Icon(
                          PinIcons.my_pin_fill,
                          size: 14,
                        ),
                      )
                    : IconButton(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.topCenter,
                        onPressed: () => changePin,
                        icon: const Icon(
                          PinIcons.my_pin_outlined,
                          size: 14,
                        ),
                      ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Created:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: mediaQuerySize.width * 0.2,
                    ),
                    Text(
                      DateFormat.MMMMd().format(widget.currentItem.time),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
