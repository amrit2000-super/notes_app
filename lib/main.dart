import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/notes_update.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {NotesDetail.routepage: (context) => NotesDetail('')},
      ),
    );
  }
}
