import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/presentation/controller/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/features/notes/data/notes_model/notes_model.dart';
import 'package:notes/features/notes/presentation/notes_widgets/note_item.dart';

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
            ? BlocProvider.of<NotesCubit>(context, listen: true).searchedForNote
            : BlocProvider.of<NotesCubit>(context).notes ?? [];
        return notes.isNotEmpty
            ? ListView.builder(
                itemCount: notes.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return NoteItem(
                    note: notes[index],
                  );
                },
              )
            : Center(
                child: Text(
                  S.of(context).add_notes_first,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
      },
    );
  }
}
