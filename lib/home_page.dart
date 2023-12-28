import 'package:flutter/material.dart';
import 'package:sqflite_project/edit_note.dart';
import 'sql_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  bool isLoading = true;
  SqlDb sqldb = SqlDb();

  void readData() async {
    //List<Map> response = await sqldb.readData("SELECT * FROM notes");
    List<Map> response = await sqldb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNote");
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                // button for test deleteMyDb function
                // MaterialButton(
                //   onPressed: () async {
                //     sqldb.deleteMyDb();
                //   },
                //   child: const Text("delete database"),
                // ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(notes[i]["title"]),
                        subtitle: Text(notes[i]["note"]),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditNote(
                                        note: notes[i]['note'],
                                        title: notes[i]['title'],
                                        id: notes[i]['id'],
                                        color: notes[i]['color'],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  int response = await sqldb.deleteData(
                                      "DELETE FROM 'notes' WHERE id = ${notes[i]['id']}");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
