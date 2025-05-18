import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/presentation/controller/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/generated/l10n.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
 
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotesCubit>(context);
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return TextField(
          controller: bloc.searchTextController,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: S.of(context).search_hint_text,
            hintStyle:
                TextStyle(color: Theme.of(context).hintColor, fontSize: 18)
                    .copyWith(color: Colors.white, fontSize: 18),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 18)
              .copyWith(color: Colors.white, fontSize: 18),
          onChanged: (searchednotes) {
            bloc.addSearchedForItemstoSearchedList(searchednotes);
          },
        );
      },
    );
  }
}
