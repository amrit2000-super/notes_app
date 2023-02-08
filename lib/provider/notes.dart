import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class NotesModel {
  final String id;
  final String userid;
  final String title;
  final String content;
  String? dateAdded;

  NotesModel(
      {required this.id,
      required this.userid,
      required this.title,
      required this.content,
      this.dateAdded});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'dateAdded': dateAdded
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> mp) {
    return NotesModel(
        id: mp['id'],
        userid: mp['userid'],
        title: mp['title'],
        content: mp['content'],
        dateAdded: mp['dateAdded']);
  }
}

List<NotesModel> _notes = [];

class NotesProvider with ChangeNotifier {
  //fetch notes from server
  Future<void> getNotes() async {
    _notes = [];
    final url = Uri.parse('http://10.0.2.2:8000/notes/list');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    for (var note in extractedData) {
      var notestemp = NotesModel.fromJson(note);
      _notes.add(notestemp);
    }
    notifyListeners();
  }

  //delete note from server
  Future<void> deleteNotes(String id) async {
    final url = Uri.parse('http://10.0.2.2:8000/notes/delete');
    final index = _notes.indexWhere((element) => element.id == id);
    final deleteProd = _notes[index];
    final response = await http.post(url, body: {"id": id});
    print(response.statusCode);
    if (response.statusCode <= 200) {
      _notes.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  //add note
  Future<void> addNote(NotesModel note) async {
    final url = Uri.parse('http://10.0.2.2:8000/notes/add');
    final response = http.post(url, body: note.toMap());
  }

  Future<void> updateNote(String id, NotesModel note) async {
    final url = Uri.parse('http://10.0.2.2:8000/notes/add');
    if (note.id != "") {
      final response = http.post(url, body: note.toMap());
    }
  }

  List<NotesModel> get notesList {
    return [..._notes];
  }

  NotesModel findById(String id) {
    var notesfound =
        NotesModel(id: '', userid: '', title: '', content: '', dateAdded: '');
    notesfound = _notes.firstWhere((element) => element.id == id);
    return notesfound;
  }
}
