import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/models/to_do_model/to_do_model.dart';
import 'package:notes/presentation/widgets/to_do_widgets/task_item.dart';

class TasksBody extends StatefulWidget {
  const TasksBody({
    super.key,
    required this.status,
  });
  final String status;
  @override
  State<TasksBody> createState() => _TasksBodyState();
}

class _TasksBodyState extends State<TasksBody> {
  @override
  void initState() {
    BlocProvider.of<ToDoCubit>(context).fetchAllToDo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        List<ToDoModel> todo = BlocProvider.of<ToDoCubit>(context).todo ?? [];
        return ListView.builder(
          itemCount: todo.length,
          padding: const EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            return todo[index].status == widget.status
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: TaskItem(
                      task: todo[index],
                    ),
                  )
                : const SizedBox.shrink();
          },
        );
      },
    );
  }
}
