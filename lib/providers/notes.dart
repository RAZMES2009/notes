import 'package:flutter/foundation.dart';

import '../models/note.dart';
import '../helpers/db_helper.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void addNote(String? text) {
    var time = DateTime.now();
    _items.add(
      Note(id: time, text: text.toString(), time: time),
    );
    DBHelper.insert(
      'notes',
      {
        'id': time.toIso8601String(),
        'text': text.toString(),
        'time': time.toIso8601String(),
        'pin': 0,
      },
    );
    notifyListeners();
  }

  Future<void> fetchData() async {
    final dataList = await DBHelper.getData('notes');
    _items = dataList
        .map(
          (item) => Note(
            id: DateTime.tryParse(item['id'])!,
            text: item['text'],
            time: DateTime.tryParse(item['time'])!,
            pinned: item['pin'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    _items.clear();
    DBHelper.clearDb();
  }

  Iterable<Note> listLargeNotes(String largeNote) {
    return _items.where((el) => el.text.length < 10);
  }
}
