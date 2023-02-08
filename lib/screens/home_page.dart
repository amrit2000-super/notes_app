import 'package:flutter/material.dart';
import 'package:notes_app/screens/notes_update.dart';
import 'package:notes_app/widgets/notes_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NotesDetail.routepage);
            },
          )
        ],
      ),
      body: Container(margin: EdgeInsets.all(10), child: NotesList()),
    );
  }
}
