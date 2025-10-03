import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note_model.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  // دالة لتحميل الملاحظات من الـ SharedPreferences
  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getStringList('notes') ?? [];
    _notes = notesData.map((note) {
      final parts = note.split("||");
      return Note(title: parts[0], content: parts[1]);
    }).toList();
    notifyListeners();
  }

  // دالة لحفظ الملاحظة في الـ SharedPreferences
  Future<void> addNote(Note note) async {
    _notes.add(note);
    final prefs = await SharedPreferences.getInstance();
    List<String> notesData = _notes.map((e) => '${e.title}||${e.content}').toList();
    await prefs.setStringList('notes', notesData);
    notifyListeners();
  }

  // دالة لحذف الملاحظة
  Future<void> deleteNote(int index) async {
    _notes.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    List<String> notesData = _notes.map((e) => '${e.title}||${e.content}').toList();
    await prefs.setStringList('notes', notesData);
    notifyListeners();
  }
}
