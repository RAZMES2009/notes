class Note {
  DateTime id;
  String text;
  DateTime time;
  bool pinned;

  Note({
    required this.id,
    required this.text,
    required this.time,
    this.pinned = false,
  });
}
