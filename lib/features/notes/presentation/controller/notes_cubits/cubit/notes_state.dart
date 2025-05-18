part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

class AddNoteSucsess extends NotesState {}

class NoteSucsess extends NotesState {}

class NoteOnChangeSearch extends NotesState {}

class ChangeBottomSheetState extends NotesState {}

class NoteOnDispose extends NotesState {}