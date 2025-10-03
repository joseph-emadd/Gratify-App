import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';
import 'note_model.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Content"),
              maxLines: 5,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final note = Note(
                  title: titleController.text,
                  content: contentController.text,
                );
                Provider.of<NoteProvider>(context, listen: false).addNote(note);
                Navigator.pop(context);
              },
              child: const Text("Save Note"),
            ),
          ],
        ),
      ),
    );
  }
}
