import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(210, 214, 217, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(210, 214, 217, 1),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Your notes'),
          actions: [
            IconButton(
              onPressed: () {
                Notes().addNote();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<Notes>(context, listen: false).fetchData(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: LinearProgressIndicator(),
                    )
                  : Consumer<Notes>(
                      child: const Center(
                        child: Text('No one notes yet, start adding some!'),
                      ),
                      builder: (ctx, notesData, ch) => notesData.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemCount: notesData.items.length,
                              itemBuilder: ((ctx, index) =>
                                  Text(notesData.items[index].text)),
                            ),
                    ),
        ),
      ),
    );
  }
}
