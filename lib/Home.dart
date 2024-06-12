import 'package:diary/Repository/notes_repository.dart';
import 'package:diary/widgets/add_note_screen.dart';
import 'package:diary/widgets/item_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Diary'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                setState(() {

                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),

        body: FutureBuilder(
            future: NotesRepository.getNotes(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.done)
                {
                  if(snapshot.data==null || snapshot.data!.isEmpty)
                {return const Center(child: Text('Empty'),);
                }
                      return ListView(
                        padding: const EdgeInsets.all(15),
                        children: [
                          for( var note in snapshot.data!)
                            ItemNote(note: note)
                        ],
                      );
                    }
                  return const SizedBox();
                }
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNoteScreen()));
        },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        )
    );
  }
}
