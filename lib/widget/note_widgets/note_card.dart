import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_todo_app/utils/extensions.dart';
import '../../controller/note_controller.dart';
import '../../models/note_model.dart';

enum Menu { delete, pinNote }

class NoteCardDesign extends StatelessWidget {
  final noteCtrl = Get.find<NoteController>();
  final NoteModel noteModel;

  NoteCardDesign({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final squareSize = Get.width - 12.0.wp;
    return Padding(
      padding: EdgeInsets.all(2.0.wp),
      child: Container(
        width: squareSize / 2,
        height: squareSize / 1.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo[200]!,
              Colors.white60,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                position: PopupMenuPosition.under,

                /// Method
                initialValue: noteModel.pinNote,
                onSelected: (selectItem) {
                  noteCtrl.onMenuItemSelect(selectItem as int,
                      noteModel.noteId ?? '');
                },
                itemBuilder: (context) {
                  return [
                    noteCtrl.buildPopMenu('Delete', Menu.delete.index),
                  ];
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.0.wp),
              child: Text(
                noteModel.titleNote ?? '',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0.sp),
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.0.wp, right: 3.0.wp),
              child: Text(
                noteModel.contentNote ?? '',
                style: TextStyle(fontSize: 11.0.sp, color: Colors.grey[900]),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }
}
