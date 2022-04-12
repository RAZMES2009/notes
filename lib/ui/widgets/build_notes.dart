import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './large_card.dart';
import './two_cards.dart';
import './small_card.dart';
import '../../providers/notes.dart';

class BuldNotes extends StatefulWidget {
  const BuldNotes({
    Key? key,
  }) : super(key: key);

  @override
  State<BuldNotes> createState() => _BuldNotesState();
}

class _BuldNotesState extends State<BuldNotes> {
  var prevIndex;
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    var existsIdNotes = [];
    return FutureBuilder(
      future: Provider.of<Notes>(context, listen: false).fetchData(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: SizedBox(
                      width: mediaQuerySize.width * 0.8,
                      child: const LinearProgressIndicator()),
                )
              : Consumer<Notes>(
                  child: const Center(
                    child: Text('No one note yet, start adding some!'),
                  ),
                  builder: (ctx, notesData, ch) => notesData.items.isEmpty
                      ? ch!
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            itemCount: notesData.items.length,
                            itemBuilder: ((c, index) {
                              existsIdNotes.add(notesData.items[index].id);
                              return buildTwoCards(notesData, index);
                            }),
                          ),
                        )),
    );
  }

  Widget buildTwoCards(Notes notesData, int index) {
    if (prevIndex != index) {
      if (notesData.items.length > 1) {
        for (var i = index + 1; i < notesData.items.length; i++) {
          if (notesData.items[i].text.length < 10) {
            prevIndex = i;
            return TwoCards(
              firstItemIndex: index,
              secondItemIndex: i,
            );
          } else {
            return LargeCard(currentItem: notesData.items[index]);
          }
        }
      } else {
        return notesData.items[index].text.length > 9
            ? LargeCard(currentItem: notesData.items[index])
            : SmallCard(currentItem: notesData.items[index]);
      }
    }
    if (notesData.items.length.isOdd && prevIndex != index) {
      return SmallCard(currentItem: notesData.items[index]);
    }
    return const SizedBox();
  }
}
