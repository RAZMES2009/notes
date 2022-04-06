import 'package:flutter/foundation.dart';

import '../models/note.dart';

class Notes with ChangeNotifier {
  final List<Note> _items = [
    Note(id: DateTime.now(), text: 'Buy milk', time: DateTime.now())
  ];

  List<Note> get items {
    return [..._items];
  }
}
