import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/note.dart';
import '../helpers/db_helper.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];
  Map<String, dynamic> data = {};

  List<Note> get items {
    return [..._items];
  }

  void addNote(String text) {
    final time = DateTime.now();
    final randNum = Random().nextInt(2);
    _items.add(
      Note(id: time, text: text.toString(), time: time, color: randNum),
    );
    DBHelper.insert(
      'notes',
      {
        'id': time.toIso8601String(),
        'text': text.toString(),
        'time': time.toIso8601String(),
        'pin': 0,
        'color': randNum,
      },
    );
    notifyListeners();
  }

  Future<void> fetchData(bool onlyPinned) async {
    final dataList = await DBHelper.getData('notes');
    if (onlyPinned) {
      print(dataList.where((el) => el['pin'] == 1));
      _items = dataList
          .where((el) => el['pin'] == true)
          .map(
            (item) => Note(
              id: DateTime.tryParse(item['id'])!,
              text: item['text'],
              time: DateTime.tryParse(item['time'])!,
              pinned: item['pin'] = true,
              color: item['color'],
            ),
          )
          .toList();
    } else {
      _items = dataList
          .map(
            (item) => Note(
              id: DateTime.tryParse(item['id'])!,
              text: item['text'],
              time: DateTime.tryParse(item['time'])!,
              pinned: item['pin'] == 0 ? false : true,
              color: item['color'],
            ),
          )
          .toList();
    }

    notifyListeners();
  }

  void deleteAllNotes() {
    _items.clear();
    DBHelper.clearDb();
  }

  void setPin(int index) {
    items[index].pinned = !items[index].pinned;

    Map<String, Object> data = {
      'id': items[index].id.toIso8601String(),
      'text': items[index].text.toString(),
      'time': items[index].time.toIso8601String(),
      'pin': items[index].pinned == true ? 1 : 0,
      'color': items[index].color,
    };

    DBHelper.updateDb(
      data,
      _items[index].id.toIso8601String(),
    );
  }
}
