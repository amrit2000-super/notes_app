import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/provider/notes.dart';
import 'package:notes_app/screens/notes_update.dart';
import 'package:provider/provider.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NotesProvider>(context, listen: false).getNotes(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : snapshot.hasError
                ? Center(
                    child: Text('An error occured'),
                  )
                : Consumer<NotesProvider>(
                    builder: (context, value, _) => RefreshIndicator(
                      onRefresh: () =>
                          Provider.of<NotesProvider>(context, listen: false)
                              .getNotes(),
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () async {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            '${value.notesList[index].title} selected',
                                          ),
                                          content:
                                              Text('What do u want to do?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Update note'),
                                              onPressed: () async {
                                                await Navigator.of(context)
                                                    .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NotesDetail(value
                                                            .notesList[index]
                                                            .id),
                                                  ),
                                                )
                                                    .then((_) {
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                });
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Delete note'),
                                              onPressed: () {
                                                value
                                                    .deleteNotes(value
                                                        .notesList[index].id)
                                                    .then((_) {
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                });
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 40, top: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellowAccent),
                                  child: Column(
                                    children: [
                                      Text(
                                        value.notesList[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(value.notesList[index].content,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(value.notesList[index].userid),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(value.notesList[index].dateAdded!),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: value.notesList.length,
                      ),
                    ),
                  ));
  }
}
