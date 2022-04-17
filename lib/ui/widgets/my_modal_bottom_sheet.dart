import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/note.dart';
import '../../providers/notes.dart';

class MyModalBottomSheet extends StatelessWidget {
  final bool isInputText;
  final Note? currentItem;
  const MyModalBottomSheet({
    Key? key,
    required this.isInputText,
    required this.currentItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    var inputTextController = TextEditingController();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: mediaQuerySize.height * 0.2,
        width: mediaQuerySize.width,
        child: isInputText
            ? InputText(
                mediaQuerySize: mediaQuerySize,
                inputTextController: inputTextController,
              )
            : AllInfoCard(
                mediaQuerySize: mediaQuerySize,
                currentItem: currentItem,
              ),
      ),
    );
  }
}

class AllInfoCard extends StatelessWidget {
  const AllInfoCard({
    Key? key,
    required this.mediaQuerySize,
    required this.currentItem,
  }) : super(key: key);

  final Size mediaQuerySize;
  final Note? currentItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: mediaQuerySize.width * 0.8,
          child: Text(currentItem!.text),
        ),
        SizedBox(
          width: mediaQuerySize.width * 0.5,
          child: ElevatedButton(
            onPressed: () {
              Provider.of<Notes>(context, listen: false)
                  .deleteNote(currentItem!);
              Provider.of<Notes>(context, listen: false).fetchData(false);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    required this.mediaQuerySize,
    required this.inputTextController,
  }) : super(key: key);

  final Size mediaQuerySize;
  final TextEditingController inputTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: mediaQuerySize.width * 0.8,
          child: TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: 'New note',
            ),
            controller: inputTextController,
            onFieldSubmitted: (String? value) {
              if (value!.isNotEmpty) {
                Provider.of<Notes>(context, listen: false).addNote(value);
                Provider.of<Notes>(context, listen: false).fetchData(false);
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
                Provider.of<Notes>(context, listen: false).fetchData(false);
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
    );
  }
}
