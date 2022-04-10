import 'package:flutter/material.dart';

import '../providers/notes.dart';
import './widgets/build_notes.dart';

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
            IconButton(
              onPressed: () {
                Notes().deleteAllNotes();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: const BuldNotes(),
      ),
    );
  }
}