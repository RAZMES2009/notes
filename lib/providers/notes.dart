import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class Notes with ChangeNotifier {
  final List<Note> _items = [
    Note(id: 'm1', text: 'Buy milk', time: DateTime.now())
  ];

  List<Note> get items {
    return [..._items];
  }
}
