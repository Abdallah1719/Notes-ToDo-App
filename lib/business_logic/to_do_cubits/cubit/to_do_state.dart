part of 'to_do_cubit.dart';

@immutable
sealed class ToDoState {}

final class ToDoInitial extends ToDoState {}

class AddToDoSucsess extends ToDoState {}

class ToDoSucsess extends ToDoState {}

class ChangeBottomNavBarState extends ToDoState {}

class ChangeBottomSheetState extends ToDoState {}
