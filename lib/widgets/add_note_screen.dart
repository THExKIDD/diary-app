import 'package:diary/Repository/notes_repository.dart';
import 'package:diary/models/note.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, this.note});
  final Note? note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
   void initState() {
    if(widget.note != null)
      {
        _title.text = widget.note!.title;
        _description.text = widget.note!.description;
      }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
        ),
        actions: [
          IconButton(onPressed: (){
            if(widget.note == null)
              {
                _insertNote;
                Navigator.pop(context);
              }
            else
              {
                _updateNote;
              }
          },
              icon: const Icon(Icons.done)
          ),
          widget.note!= null ?
          IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: const Text('Are u sure u want to delete this node?'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        child: const Text('No'),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      _deleteNote();
                    },
                      child: const Text('Yes'),
                    )
                  ],
                ));
              },
              icon: const Icon(Icons.delete))
              : const SizedBox(),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Expanded(
              child: TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
          ),
          SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _description,
              decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
              maxLines: 20,
            ),
          ),
        ],
      ),
    );
  }
  _insertNote() async {
    final note = Note(title: _title.text,
        description: _description.text,
        createdAt: DateTime.now()
    );
    await NotesRepository.insert(note: note);
  }

  _updateNote() async {
    final note = Note(
      id: widget.note!.id!,
      title: _title.text,
        description: _description.text,
        createdAt: widget.note!.createdAt,
    );
    await NotesRepository.update(note: note);
  }

_deleteNote() async {
    NotesRepository.delete(note: widget.note!).then((e) {
      Navigator.pop(context);
    });
}
}
