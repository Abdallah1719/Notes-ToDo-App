import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/features/todo/presentation/controller/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/features/todo/data/to_do_model/to_do_model.dart';
import 'package:notes/core/global_widgets/components.dart';
import 'package:notes/core/global_widgets/drawer_content.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var scaffoldKye = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formkey = GlobalKey();
  String? title, time, date;
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime? input = datecontroller.text.isNotEmpty
        ? DateFormat('dd/MM/yyyy').parse(datecontroller.text)
        : null;
    return BlocConsumer<ToDoCubit, ToDoState>(
      listener: (context, state) {},
      builder: (context, state) {
        ToDoCubit todoCubit = ToDoCubit.get(context);
        return Scaffold(
          key: scaffoldKye,
          drawer: const Drawer(
            child: DrawerContent(),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              S.of(context).to_do_title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          
          ),
        
          body: todoCubit.screens[todoCubit.currentidex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: todoCubit.currentidex,
              selectedItemColor: Colors.grey[600],
              unselectedItemColor: Theme.of(context).iconTheme.color,
              onTap: (index) {
                todoCubit.changeIndx(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: S.of(context).tasks_label,
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    label: S.of(context).done_label),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: S.of(context).archived_label,
                ),
              ]),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onPressed: () {
              if (todoCubit.isBottomSheetShown) {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  var todomodel = ToDoModel(
                      title: title!,
                      time: time!,
                      date: input.toString(),
                      status: 'new');
                  BlocProvider.of<ToDoCubit>(context).addToDo(todomodel);
                  close();
                  todoCubit.changeBottomSheetState(
                      isShow: false, icon: Icons.edit);
                }
              } else {
                scaffoldKye.currentState
                    ?.showBottomSheet(
                        backgroundColor: Theme.of(context)
                            .bottomSheetTheme
                            .backgroundColor, (context) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                        ),
                        child: BlocListener<ToDoCubit, ToDoState>(
                          listener: (context, state) {
                            if (state is AddToDoSucsess) {
                              BlocProvider.of<ToDoCubit>(context)
                                  .fetchAllToDo();
                              Navigator.pop(context);
                            }
                          },
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                ToDoTextFormFiled(
                                  onSaved: (value) {
                                    title = value;
                                  },
                                  label: S.of(context).task_title_label,
                                  maxline: 1,
                                  controller: titlecontroller,
                                  keyboardType: TextInputType.text,
                                  prefix: Icons.title,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timecontroller.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  child: ToDoTextFormFiled(
                                    enabled: false,
                                    onSaved: (value) {
                                      time = value;
                                    },
                                    label: S.of(context).task_time_label,
                                    controller: timecontroller,
                                    keyboardType: TextInputType.datetime,
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 5000)))
                                        .then((value) {
                                     
                                      if (value != null) {
                                        datecontroller.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(value);
                                        setState(() {});
                                      }
                                      
                                    });
                                  },
                                  child: ToDoTextFormFiled(
                                    enabled: false,
                                    onSaved: (value) {
                                      date = value;
                                    },
                                    label: S.of(context).task_date_label,
                                    controller: datecontroller,
                                    keyboardType: TextInputType.datetime,
                                    prefix: Icons.calendar_today,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                    .closed
                    .then((value) {
                      close();
                      todoCubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });
                close();
                todoCubit.changeBottomSheetState(isShow: true, icon: Icons.add);
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              todoCubit.fabIcon,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        );
      },
    );
  }

  close() {
    titlecontroller.clear();
    timecontroller.clear();
    datecontroller.clear();
  }
}
