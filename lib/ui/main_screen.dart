import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notesData = context.watch<Notes>();
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
        ),
        body: ListView.builder(
          itemCount: notesData.items.length,
          itemBuilder: ((ctx, index) => Text(notesData.items.single.text)),
        ),
      ),
    );
  }
}
