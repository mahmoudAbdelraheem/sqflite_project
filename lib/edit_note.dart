import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sql_db.dart';

class EditNote extends StatefulWidget {
  final String note;
  final String title;
  final int id;
  final String color;

  const EditNote(
      {super.key,
      required this.note,
      required this.title,
      required this.id,
      required this.color});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final SqlDb _sqlDb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteColor = TextEditingController();

  void initState() {
    note.text = widget.note;
    noteTitle.text = widget.title;
    noteColor.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
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
                      int response = await _sqlDb.updateData('''
                        UPDATE 'notes' SET 
                        note = '${note.text}' ,
                        title = '${noteTitle.text}',
                        color = '${noteColor.text}' 
                        WHERE id = ${widget.id};
                      ''');
                      print(
                          "=================== $response =====================");
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      }
                    },
                    child: const Text("Edit Note"),
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
