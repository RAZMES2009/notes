import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/notes.dart';
import './ui/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Notes(),
      child: const MainScreen(),
    ),
  );
}
