import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './large_card.dart';
import 'note_card.dart';
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
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
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
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 9 / 7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: notesData.items.length,
                        itemBuilder: ((c, index) {
                          return NoteCard(
                            currentItem: notesData.items[index],
                          );
                        }),
                      ),
                    )),
    );
  }
}
