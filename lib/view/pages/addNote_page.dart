import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/note_controller.dart';
import '../../models/note_model.dart';

class AddNote extends StatelessWidget {
  final noteCtrl = Get.find<NoteController>();

  AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                TextButton(
                  onPressed: () {
                    if(noteCtrl.titleNoteCtrl.text != ''){
                      NoteModel notes = NoteModel(
                        titleNote: noteCtrl.titleNoteCtrl.text,
                        contentNote: noteCtrl.contentNoteCtrl.text,);
                      noteCtrl.addNote(notes);
                      noteCtrl.titleNoteCtrl.clear();
                      noteCtrl.contentNoteCtrl.clear();
                      Get.back();
                    }

                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
              child: TextFormField(
                controller: noteCtrl.titleNoteCtrl,
                autofocus: true,
                style: const TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: TextFormField(
                controller: noteCtrl.contentNoteCtrl,
                style: const TextStyle(fontSize: 17.0),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Content',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
