

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/business_logic/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/models/to_do_model/to_do_model.dart';
import 'package:notes/styles/colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final ToDoModel task;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yy').format(DateTime.parse(task.date));
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
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: beige,
                radius: 36.0,
                child: Text(task.time,
                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 12.0,
                    )),
              ),
              const SizedBox(width: 12),
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
                      date,
                      style: const TextStyle(color: lightBlue),
                    )
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  task.status = 'done';
                  task.save();
                  BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
                 
                },
                icon: const Icon(Icons.check_box),
                color: beige,
              ),
              IconButton(
                onPressed: () {
                  task.status = 'archive';
                  task.save();
                  BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
                 
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
