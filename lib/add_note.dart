import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sql_db.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final SqlDb _sqlDb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteColor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: noteTitle,
                    decoration: const InputDecoration(
                      hintText: "note title",
                    ),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: "note",
                    ),
                  ),
                  TextFormField(
                    controller: noteColor,
                    decoration: const InputDecoration(
                      hintText: "note Color",
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      //   int response = await _sqlDb.insertData('''
                      //   INSERT INTO 'notes' ( `title` , `note` , `color` )
                      //   VALUES ( "${noteTitle.text}" , "${note.text}" , "${noteColor.text}" )
                      // ''');

                      int response = await _sqlDb.insert("notes", {
                        'title': noteTitle.text,
                        'note': note.text,
                        'color': noteColor.text,
                      });

                      print(
                          "=================== $response =====================");
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      }
                    },
                    child: const Text("Add Note"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
