import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/business_logic/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/models/to_do_model/to_do_model.dart';
import 'package:notes/presentation/shared/components.dart';
import 'package:notes/presentation/widgets/shared_widgets/custom_appbar.dart';
import 'package:notes/presentation/widgets/shared_widgets/drawer_content.dart';
import 'package:notes/styles/colors.dart';

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
          appBar: const CustomAppbar(
            title: 'To Do',
          ),
          body: todoCubit.screens[todoCubit.currentidex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: todoCubit.currentidex,
              onTap: (index) {
                todoCubit.changeIndx(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
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
                    ?.showBottomSheet((context) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.only(
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
                                  label: 'Task Title',
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
                                    label: 'Task Time',
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
                                      // datecontroller.text =
                                      // DateTime.now().toIso8601String();
                                      if (value != null) {
                                        datecontroller.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(value);
                                        setState(() {});
                                      }
                                      // DateFormat('dd/MM/yyyy').format(value!);
                                    });
                                  },
                                  child: ToDoTextFormFiled(
                                    enabled: false,
                                    onSaved: (value) {
                                      date = value;
                                    },
                                    label: 'Task Date',
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
            backgroundColor: darkBlue,
            child: Icon(
              todoCubit.fabIcon,
              color: beige,
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

// class AddToDoBottomSheet extends StatelessWidget {
//   const AddToDoBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SingleChildScrollView(
//       padding: EdgeInsets.only(
//         right: 20,
//         left: 20,
//       ),
//       child: AddTODOForm(),
//     );
//   }
// }

// class AddTODOForm extends StatefulWidget {
//   const AddTODOForm({
//     super.key,
//   });

//   @override
//   State<AddTODOForm> createState() => _AddTODOFormState();
// }

// class _AddTODOFormState extends State<AddTODOForm> {
//   final GlobalKey<FormState> formkey = GlobalKey();
//   String? title, content;
//   var titlecontroller = TextEditingController();
//   var timecontroller = TextEditingController();
//   var datecontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formkey,
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           ToDoTextFormFiled(
//             label: 'Task Title',
//             maxline: 1,
//             controller: titlecontroller,
//             keyboardType: TextInputType.text,
//             prefix: Icons.title,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ToDoTextFormFiled(
//               label: 'Task Time',
//               controller: timecontroller,
//               keyboardType: TextInputType.datetime,
//               prefix: Icons.watch_later_outlined,
//               onTap: () {
//                 showTimePicker(context: context, initialTime: TimeOfDay.now())
//                     .then((value) {
//                   timecontroller.text = value!.format(context).toString();
//                 });
//               }),
//           const SizedBox(
//             height: 20,
//           ),
//           ToDoTextFormFiled(
//             label: 'Task Date',
//             controller: datecontroller,
//             keyboardType: TextInputType.datetime,
//             prefix: Icons.calendar_today,
//             onTap: () {
//               showDatePicker(
//                       context: context,
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.parse('2024-11-19'))
//                   .then((value) {
//                 datecontroller.text = DateFormat.yMd().format(value!);
//               });
//             },
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BottomNavigationBarItems extends StatefulWidget {
//   const BottomNavigationBarItems({
//     super.key,
//   });

//   @override
//   State<BottomNavigationBarItems> createState() =>
//       _BottomNavigationBarItemsState();
// }

// class _BottomNavigationBarItemsState extends State<BottomNavigationBarItems> {
//   int currentidex = 0;

//   List<Widget> screens = [
//     const TasksBody(),
//     const DoneBody(),
//     const ArchivedBody(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentidex,
//         onTap: (index) {
//           setState(() {
//             currentidex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
//           BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Done'),
//           BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Archived'),
//         ]);
//   }
// }
