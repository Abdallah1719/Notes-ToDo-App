import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/constant.dart';
import 'package:notes/models/notes_model/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  final GlobalKey<FormState> formkey = GlobalKey();
  addNote(NotesModel note) async {
    var notesbox = Hive.box<NotesModel>(knotesBox);
    await notesbox.add(note);
    emit(AddNoteSucsess());
  }

  List<NotesModel>? notes;
  fetchAllNotes() {
    log('/*/*/*/*/*/*/*');
    var notesbox = Hive.box<NotesModel>(knotesBox);
    notes = notesbox.values.toList()
      ..sort(
          (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
    emit(NoteSucsess());
  }

  late List<NotesModel> searchedForNote = [];
  final searchTextController = TextEditingController();

  void addSearchedForItemstoSearchedList(String searchednotes) {
    searchedForNote = notes!.where((search) {
      return search.title.startsWith(searchednotes.toLowerCase()) ||
          search.subtitle.startsWith(searchednotes.toLowerCase());
    }).toList();
    emit(NoteOnChangeSearch());
    log('${searchedForNote.length}');
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }

  // @override
  // Future<void> close() {
  //   searchTextController.dispose();
  //   searchTextController.clear();
  //   searchedForNote.clear();
  //   emit(NoteOnDispose());
  //   log('sasa');
  //   return super.close();
  // }
}
