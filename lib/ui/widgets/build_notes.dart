import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../icon/pin_icons.dart';

import './large_card.dart';
import './two_cards.dart';
import './small_card.dart';
import '../../providers/notes.dart';

class BuldNotes extends StatelessWidget {
  const BuldNotes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indexShortItem = 0;

    Widget buildSmallCards(var shortItemLength, var currentItem) {
      if (indexShortItem < shortItemLength - 1) {
        final mediumCard = TwoCards(index: indexShortItem);
        indexShortItem += 2;
        return mediumCard;
      } else if (indexShortItem + 1 == shortItemLength) {
        return Row(
          children: [
            SmallCard(currentItem: currentItem),
            const SizedBox(),
          ],
        );
      } else {
        return const SizedBox();
      }
    }

    final mediaQuerySize = MediaQuery.of(context).size;
    var existsIdNotes = [];
    return FutureBuilder(
      future: Provider.of<Notes>(context, listen: false).fetchData(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
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
                          return notesData.items[index].text.length > 9
                              ? LargeCard(currentItem: notesData.items[index])
                              : buildSmallCards(notesData.shortItem().length,
                                  notesData.items[index]);
                        }),
                      ),
                    )),
    );
  }
}
