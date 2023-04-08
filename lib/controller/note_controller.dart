import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/note_model.dart';
import '../services/databaseConn.dart';
import '../widget/note_widgets/note_card.dart';

class NoteController extends GetxController {
  TextEditingController titleNoteCtrl = TextEditingController();
  TextEditingController contentNoteCtrl = TextEditingController();
  NoteModel noteMdl = NoteModel();
  final Database _dbNote = Database();
  var appBarHeight = AppBar().preferredSize.height;
  final _popMenuItemSelected = 0.obs;
  final pinNoteState = false;
  final isLightTheme = false.obs;

  Rxn<List<NoteModel>> noteDetails = Rxn<List<NoteModel>>();

  List<NoteModel>? get notes => noteDetails.value;

  Rxn<List<NoteModel>> pinNotes = Rxn<List<NoteModel>>();

  List<NoteModel>? get pinnedNote => pinNotes.value;

  @override
  void onInit() {
    noteDetails.bindStream(streamNotes());
    pinNotes.bindStream(steamPinNotes());
    super.onInit();
  }

  @override
  void onClose() {
    titleNoteCtrl.dispose();
    contentNoteCtrl.dispose();
    super.onClose();
  }

  Future addNote(NoteModel noteModel) async {
    await _dbNote.firestore.collection('note-fb').doc().set({
      'Title': noteModel.titleNote,
      'Content': noteModel.contentNote,
      'PinNote': pinNoteState,
      'DateCreated': DateTime.now(),
    });
  }

  Stream<List<NoteModel>?> streamNotes() {
    var result = _dbNote.firestore
        .collection('note-fb')
        .where('PinNote', isEqualTo: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<NoteModel> list = [];

      querySnapshot.docs.forEach((element) {
        list.add(NoteModel.fromDocumentSnap(element));
      });
      return list;
    });

    return result;
  }

  /// Call Pin notes list
  Stream<List<NoteModel>?> steamPinNotes() {
    var pinResult = _dbNote.firestore
        .collection('note-fb')
        .where('PinNote', isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot pinSnap) {
      List<NoteModel> pinList = [];
      pinSnap.docs.forEach((element) {
        pinList.add(NoteModel.fromDocumentSnap(element));
      });
      return pinList;
    });
    return pinResult;
  }


  Future editNote(NoteModel notesM, String? noteId) async {
    await _dbNote.firestore.collection('note-fb').doc(noteId).update({
      'Title': notesM.titleNote,
      'Content': notesM.contentNote,
    });
  }

  PopupMenuItem buildPopMenu(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Text(title),
    );
  }

  onMenuItemSelect(int value, String noteId) {
    _popMenuItemSelected.value = value;
    if (value == Menu.delete.index) {
      deleteNote(noteId);
    } else if (value == Menu.pinNote.index) {
      pinNoted(noteId, noteMdl.pinNote!);
    } else {
      return null;
    }
  }

  void deleteNote(String? noteId) {
    _dbNote.firestore.collection('note-fb').doc(noteId).delete();
  }

  Checkbox changePinState(bool? val) {
    var result = Checkbox(
      value: noteMdl.pinNote,
      onChanged: (newValue) {
        noteMdl.pinNote = newValue!;
      },
    );
    return result;
  }

  void pinNoted(String noteId, bool val) {
    _dbNote.firestore.collection('note-fb').doc(noteId).update({
      'PinNote': changePinState(val),
    });
  }
}
