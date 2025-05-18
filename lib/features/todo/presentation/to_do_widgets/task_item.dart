import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/features/todo/presentation/controller/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/features/todo/data/to_do_model/to_do_model.dart';

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
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 36.0,
                child: Text(task.time,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(task.title,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodySmall,
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
                color: Theme.of(context).iconTheme.color,
              ),
              IconButton(
                onPressed: () {
                  task.status = 'archive';
                  task.save();
                  BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
                },
                icon: const Icon(Icons.archive),
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
