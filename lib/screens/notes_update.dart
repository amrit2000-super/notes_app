import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/provider/notes.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NotesDetail extends StatefulWidget {
  static const routepage = '/notes-details';
  final String id;
  NotesDetail(this.id);

  @override
  State<NotesDetail> createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  var dateselected = DateFormat.yMd().format(DateTime.now());
  var productFound =
      NotesModel(id: '', userid: '', title: '', content: '', dateAdded: '');
  final _key = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (widget.id != '') {
      productFound = Provider.of<NotesProvider>(context, listen: false)
          .findById(widget.id);
      setState(() {
        dateselected = productFound.dateAdded == null
            ? DateFormat.yMd().format(DateTime.now())
            : productFound.dateAdded!;
      });
    } else {
      productFound = NotesModel(
          id: Uuid().v1(), userid: '', title: '', content: '', dateAdded: '');
    }
    print(productFound);
    super.didChangeDependencies();
  }

  void saveData() {
    final _fomValidate = _key.currentState!.validate();
    if (!_fomValidate) {
      return;
    }
    _key.currentState!.save();
    if (widget.id != '') {
      Provider.of<NotesProvider>(context, listen: false)
          .updateNote(widget.id, productFound)
          .then((_) {
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<NotesProvider>(context, listen: false)
          .addNote(productFound)
          .then((_) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notes details')),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: productFound.userid,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'email-id',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8))),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  productFound = NotesModel(
                      id: productFound.id,
                      userid: newValue.toString(),
                      title: productFound.title,
                      content: productFound.content,
                      dateAdded: productFound.dateAdded);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter the user id';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                initialValue: productFound.title,
                decoration: InputDecoration(
                    labelText: 'title',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8))),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  productFound = NotesModel(
                      id: productFound.id,
                      userid: productFound.userid,
                      title: newValue.toString(),
                      content: productFound.content,
                      dateAdded: productFound.dateAdded);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter the title';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                initialValue: productFound.content,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'content',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8))),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  productFound = NotesModel(
                      id: productFound.id,
                      userid: productFound.userid,
                      title: productFound.title,
                      content: newValue.toString(),
                      dateAdded: productFound.dateAdded);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter the content';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                initialValue: productFound.dateAdded,
                decoration: InputDecoration(
                    labelText: 'date added',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.calendar_month_outlined),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1912),
                                lastDate: DateTime.now())
                            .then((value) {
                          if (value == null) {
                            setState(() {
                              dateselected =
                                  DateFormat.yMd().format(DateTime.now());
                            });
                          } else {
                            setState(() {
                              dateselected = DateFormat.yMd().format(value);
                            });
                          }
                        });
                      },
                    )),
                textInputAction: TextInputAction.done,
                onSaved: (newValue) {
                  productFound = NotesModel(
                      id: productFound.id,
                      userid: productFound.userid,
                      title: productFound.title,
                      content: productFound.content,
                      dateAdded: newValue.toString());
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter the date';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (_) => saveData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
