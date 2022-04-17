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
    final mediaQuerySize = MediaQuery.of(context).size;
    var inputTextController = TextEditingController();
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
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: mediaQuerySize.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: mediaQuerySize.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'New note',
                        ),
                        controller: inputTextController,
                        onFieldSubmitted: (String? value) {
                          if (value!.isNotEmpty) {
                            Provider.of<Notes>(context, listen: false)
                                .addNote(value);
                            Provider.of<Notes>(context, listen: false)
                                .fetchData(false);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: mediaQuerySize.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          if (inputTextController.text.isNotEmpty) {
                            Provider.of<Notes>(context, listen: false)
                                .addNote(inputTextController.text);
                            Provider.of<Notes>(context, listen: false)
                                .fetchData(false);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Add note',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add, size: 48),
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
              notesFunctions.fetchData(false);
            }
            if (index == 1) {
              notesFunctions.fetchData(true);
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
