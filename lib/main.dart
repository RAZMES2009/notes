import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/notes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Notes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notesData = context.watch<Notes>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
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
