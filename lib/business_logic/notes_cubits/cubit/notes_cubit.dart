import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/constant.dart';
import 'package:notes/models/notes_model/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  final GlobalKey<FormState> formkey = GlobalKey();
  Color color = Color(0xff55DDE0);
  addNote(NotesModel note) async {
    note.color = color.value;
    var notesbox = Hive.box<NotesModel>(knotesBox);
    await notesbox.add(note);
    emit(AddNoteSucsess());
  }

  List<NotesModel>? notes;
  // fetchAllNotes() {
  //   var notesbox = Hive.box<NotesModel>(knotesBox);
  //   notes = notesbox.values.toList()
  //     ..sort(
  //         (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
  //   emit(NoteSucsess());
  // }
  fetchAllNotes() {
    var notesbox = Hive.box<NotesModel>(knotesBox);
    notes = notesbox.values.toList()
      ..sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1; // المثبتة أولاً
        if (!a.isPinned && b.isPinned) return 1;
        return DateTime.parse(b.date)
            .compareTo(DateTime.parse(a.date)); // الفرز حسب التاريخ
      });
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
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }

  void togglePinStatus(NotesModel note) async {
    var notesBox = Hive.box<NotesModel>(knotesBox);
    note.isPinned = !note.isPinned; // تبديل حالة التثبيت
    await note.save(); // حفظ التغييرات في Hive
    fetchAllNotes(); // إعادة تحميل الملاحظات
    emit(NoteSucsess());
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
