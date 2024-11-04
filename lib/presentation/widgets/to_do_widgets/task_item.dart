import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/models/to_do_model/to_do_model.dart';
import 'package:notes/styles/colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final ToDoModel task;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
        BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
      },
      child: Container(
        decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: beige,
                radius: 40.0,
                child: Text(task.time, style: const TextStyle(color: darkBlue)),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(task.title,
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: beige)),
                    Text(
                      task.date,
                      style: const TextStyle(color: lightBlue),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 70,
              ),
              IconButton(
                onPressed: () {
                  task.status = 'done';
                  task.save();
                  BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
                  log(task.status);
                },
                icon: const Icon(Icons.check_box),
                color: beige,
              ),
              IconButton(
                onPressed: () {
                  task.status = 'archive';
                  task.save();
                  BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
                  log(task.status);
                },
                icon: const Icon(Icons.archive),
                color: beige,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
