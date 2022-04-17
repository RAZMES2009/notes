import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../icon/pin_icons.dart';
import '../providers/notes.dart';
import './widgets/build_notes.dart';
import './widgets/my_modal_bottom_sheet.dart';

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color.fromRGBO(242, 116, 5, 1),
            ),
          ),
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
        floatingActionButton: const MyFAB(),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class MyFAB extends StatelessWidget {
  const MyFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          context: context,
          builder: (BuildContext ctx) {
            return const MyModalBottomSheet(
              isInputText: true,
              currentItem: null,
            );
          },
        );
      },
      child: const Icon(Icons.add, size: 48),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    bool onlyPinned = false;
    final notesFunctions = Provider.of<Notes>(context, listen: false);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
          onTap: (int index) {
            if (index == 0) {
              notesFunctions.deleteAllNotes();
              notesFunctions.fetchData(onlyPinned);
            }
            if (index == 1) {
              onlyPinned = !onlyPinned;
              notesFunctions.fetchData(!onlyPinned);
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
                  PinIcons.my_pin_fill,
                  size: 30,
                ),
              ),
              label: '',
            )
          ]),
    );
  }
}
