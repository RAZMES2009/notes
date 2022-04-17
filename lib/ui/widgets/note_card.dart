import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/providers/notes.dart';
import 'package:notes/ui/widgets/my_modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../icon/pin_icons.dart';

class NoteCard extends StatefulWidget {
  final int index;
  const NoteCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<Notes>(context, listen: false);
    Color colorCard = notesData.items[widget.index].color == 1
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.tertiary;
    final mediaQuerySize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          context: context,
          builder: (BuildContext ctx) => MyModalBottomSheet(
            isInputText: false,
            currentItem: notesData.items[widget.index],
          ),
        );
      },
      child: Container(
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
                    height: mediaQuerySize.width * 0.12,
                    child: Text(
                      notesData.items[widget.index].text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  notesData.items[widget.index].pinned
                      ? IconButton(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          alignment: Alignment.topCenter,
                          onPressed: () => setState(() {
                            notesData.setPin(widget.index);
                          }),
                          icon: const Icon(
                            PinIcons.my_pin_fill,
                            size: 14,
                            color: Color.fromRGBO(242, 116, 5, 1),
                          ),
                        )
                      : IconButton(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          alignment: Alignment.topCenter,
                          onPressed: () => setState(() {
                            notesData.setPin(widget.index);
                          }),
                          icon: const Icon(
                            PinIcons.my_pin_outlined,
                            size: 14,
                            color: Color.fromRGBO(242, 116, 5, 1),
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
                        DateFormat.MMMMd()
                            .format(notesData.items[widget.index].time),
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
      ),
    );
  }
}
