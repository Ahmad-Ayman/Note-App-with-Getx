import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newnote/helper/database_services/database_helper.dart';
import 'package:newnote/model/Note.dart';
import 'package:share_plus/share_plus.dart';
import 'package:string_stats/string_stats.dart';

class NoteController extends GetxController {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var notes = <Note>[];
  int contentWordCount = 0;
  int characterCount = 0;
  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty() {
    if (notes.length == 0) {
      return true;
    }
    return false;
  }

  void addNote() async {
    var title = titleController.text;
    if (title.isBlank!) {
      title = "unnamed";
    }
    var content = contentController.text;
    Note newNote = Note(
      title: title,
      content: content,
      dateTimeCreated: DateFormat("MM dd yyyy HH:mm:ss").format(DateTime.now()),
      dateTimeEdited: DateFormat("MM dd yyyy HH:mm:ss").format(DateTime.now()),
    );
    await DatabaseHelper.instance.addNote(newNote);
    contentWordCount = wordCount(content);
    characterCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(
      id: id,
    );
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }

  void updateNote(int id, String dtCreated) async {
    log('update $id');
    var title = titleController.text;
    var content = contentController.text;
    if (title.isBlank!) {
      title = "unnamed";
    }
    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeCreated: dtCreated,
      dateTimeEdited: DateFormat("MM dd yyyy HH:mm:ss").format(DateTime.now()),
    );
    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(content);
    characterCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getNoteList();
    log('notes length ${notes.length}');
    update();
  }

  void shareNote(String title, String content) {
    Share.share("""$title
    Create By Ahmed Ayman """);
  }
}
