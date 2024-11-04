import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes/constant.dart';
import 'package:notes/models/notes_model/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  addNote(NotesModel note) async {
    var notesbox = Hive.box<NotesModel>(knotesBox);
    await notesbox.add(note);
    emit(AddNoteSucsess());
  }

  List<NotesModel>? notes;
  fetchAllNotes() {
    log('/*/*/*/*/*/*/*');
    var notesbox = Hive.box<NotesModel>(knotesBox);
    notes = notesbox.values.toList();
    emit(NoteSucsess());
  }
}
