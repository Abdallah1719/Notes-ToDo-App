import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/presentation/widgets/notes_widgets/note_item.dart';

class NotesBody extends StatefulWidget {
  const NotesBody({super.key, required this.isSearcing});
  final bool isSearcing;
  @override
  State<NotesBody> createState() => _NotesBodyState();
}

class _NotesBodyState extends State<NotesBody> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        List<NotesModel> notes = widget.isSearcing
            ? BlocProvider.of<NotesCubit>(context).searchedForNote
            : BlocProvider.of<NotesCubit>(context).notes ?? [];
        return ListView.builder(
          itemCount: notes.length,
          padding: const EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            return NoteItem(
              note: notes[index],
            );
          },
        );
      },
    );
  }
}
