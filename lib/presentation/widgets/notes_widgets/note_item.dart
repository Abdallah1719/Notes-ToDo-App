import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/presentation/screens/edit_screen.dart';
import 'package:notes/styles/colors.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
  });

  final NotesModel note;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditScreen(
                      note: note,
                    )),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.circular(21),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 20, right: 5),
                title: Text(
                  note.title,
                  style: const TextStyle(
                      color: beige, fontSize: 32, fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  note.subtitle,
                  style: const TextStyle(
                    color: beige,
                    fontSize: 22,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    note.delete();
                    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 32,
                  ),
                  color: beige,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  note.date,
                  style: const TextStyle(
                    color: beige,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
