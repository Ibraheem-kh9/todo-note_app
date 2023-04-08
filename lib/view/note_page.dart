import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_todo_app/view/pages/addNote_page.dart';
import '../controller/note_controller.dart';
import '../widget/note_widgets/note_card.dart';
import 'pages/noteDetails_page.dart';

class NotePage extends GetView {
  final noteCtrl = Get.put<NoteController>(NoteController());

  NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => GridView.count(
            crossAxisCount: 2,
            children: [
              ...?noteCtrl.pinnedNote?.map(
                (e) => GestureDetector(
                  onTap: () {
                    Get.to(() => NoteDetails(noteModel: e));
                  },
                  child: NoteCardDesign(noteModel: e),
                ),
              ),
              ...?noteCtrl.notes?.map(
                (e) => GestureDetector(
                  onTap: () {
                    Get.to(() => NoteDetails(noteModel: e));
                  },
                  child: NoteCardDesign(noteModel: e),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          noteCtrl.contentNoteCtrl.clear();
          noteCtrl.titleNoteCtrl.clear();
          await Get.dialog(AddNote());
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

