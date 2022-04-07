import 'package:flutter/material.dart';
import 'package:notes/icon/pin_icons.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';
import '../../icon/pin_icons.dart';

class BuldNotes extends StatelessWidget {
  const BuldNotes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Provider.of<Notes>(context, listen: false).fetchData(),
      builder: (ctx, snapshot) =>
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
                      : ListView.builder(
                          itemCount: notesData.items.length,
                          itemBuilder: ((ctx, index) => Row(
                                children: [
                                  Card(
                                    child: Row(
                                      children: [
                                        Text(notesData.items[index].text),
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
                                ],
                              )),
                        ),
                ),
    );
  }
}
