import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/constant.dart';
import 'package:notes/models/to_do_model/to_do_model.dart';
import 'package:notes/presentation/widgets/to_do_widgets/tasks_body.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  ToDoCubit() : super(ToDoInitial());

  static ToDoCubit get(context) => BlocProvider.of(context);

  addToDo(ToDoModel todo) async {
    var todobox = Hive.box<ToDoModel>(ktodoBox);

    await todobox.add(todo);
    log('/*/*/*/*/*/*/*');
    emit(AddToDoSucsess());
  }

  List<ToDoModel>? todo;
  fetchAllToDo() {
    log('/*/*/*/*/*/*/*');
    var todobox = Hive.box<ToDoModel>(ktodoBox);
    todo = todobox.values.toList()
    ..sort(
          (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
    emit(ToDoSucsess());
  }

  int currentidex = 0;

  List<Widget> screens = [
    const TasksBody(status: 'new'),
    const TasksBody(status: 'done'),
    const TasksBody(status: 'archive'),
    // const DoneBody(),
    // const ArchivedBody(),
  ];

  void changeIndx(int index) {
    currentidex = index;
    emit(ChangeBottomNavBarState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }
}
