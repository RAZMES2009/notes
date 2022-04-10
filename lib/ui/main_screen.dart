import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(242, 116, 5, 1),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(210, 214, 217, 1),
          secondary: const Color.fromRGBO(13, 166, 79, 1),
          tertiary: const Color.fromRGBO(4, 191, 69, 1),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Your notes',
            style: TextStyle(
              fontSize: 36,
              color: Colors.black,
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: BuldNotes(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.large(
          onPressed: () => Provider.of<Notes>(context, listen: false).addNote(),
          child: const Icon(Icons.add, size: 48),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesFunctions = Provider.of<Notes>(context, listen: false);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
          onTap: (int index) {
            if (index == 0) {
              notesFunctions.deleteAllNotes();
              notesFunctions.fetchData();
            }
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 55),
                child: Icon(
                  Icons.checklist_sharp,
                  size: 45,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 55),
                child: Icon(
                  Icons.more_vert,
                  size: 45,
                ),
              ),
              label: '',
            )
          ]),
    );
  }
}
