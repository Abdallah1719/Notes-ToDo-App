import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/styles/colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<NotesModel> notes = [];

  @override
  void initState() {
    notes = BlocProvider.of<NotesCubit>(context).notes ?? [];
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<NotesCubit>(context).searchTextController.dispose();
    BlocProvider.of<NotesCubit>(context).searchTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotesCubit>(context);
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return TextField(
          controller: bloc.searchTextController,
          cursorColor: beige,
          decoration: const InputDecoration(
            hintText: 'search notes',
            hintStyle: TextStyle(color: beige, fontSize: 18),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: beige, fontSize: 18),
          onChanged: (searchednotes) {
            bloc.addSearchedForItemstoSearchedList(searchednotes);
          },
        );
      },
    );
  }
}
