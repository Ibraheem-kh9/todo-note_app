import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/note_controller.dart';
import '../../models/note_model.dart';


class NoteDetails extends StatelessWidget {
  final noteCtrl = Get.find<NoteController>();
  final NoteModel noteModel;

  Future onInit() async {
    noteCtrl.titleNoteCtrl =
        TextEditingController(text: noteModel.titleNote ?? '');
    noteCtrl.contentNoteCtrl =
        TextEditingController(text: noteModel.contentNote ?? '');
  }

  NoteDetails({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onInit();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    NoteModel notes = NoteModel(
                      titleNote: noteCtrl.titleNoteCtrl.text,
                      contentNote: noteCtrl.contentNoteCtrl.text,
                    );
                    noteCtrl.editNote(notes,noteModel.noteId);
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                TextButton(
                  onPressed: () {
                    //                   if(noteCtrl.titleNoteCtrl.text != ''){
                    NoteModel notes = NoteModel(
                      titleNote: noteCtrl.titleNoteCtrl.text,
                      contentNote: noteCtrl.contentNoteCtrl.text,
                    );
                    noteCtrl.editNote(notes,noteModel.noteId);
                    Get.back();
                    // }
                    // else{
                    //   return;
                    // }
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
