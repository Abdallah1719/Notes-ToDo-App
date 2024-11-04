import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/presentation/shared/components.dart';
import 'package:notes/presentation/widgets/notes_widgets/notes_body.dart';
import 'package:notes/presentation/widgets/shared_widgets/custom_appbar.dart';
import 'package:notes/presentation/widgets/shared_widgets/drawer_content.dart';
import 'package:notes/styles/colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  var scaffoldKye = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  final GlobalKey<FormState> formkey = GlobalKey();
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKye,
      drawer: const Drawer(
        child: DrawerContent(),
      ),
      appBar: const CustomAppbar(
        title: 'Notes',
      ),
      body: const NotesBody(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () {
          if (isBottomSheetShown) {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();
              var currentDate = DateTime.now();
              var formatcurrentDate =
                  DateFormat('dd/mm/yy').format(currentDate);
              var notemodel = NotesModel(
                title: title!,
                subtitle: content!,
                date: formatcurrentDate,
              );
              BlocProvider.of<NotesCubit>(context).addNote(notemodel);

              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            }
          } else {
            scaffoldKye.currentState?.showBottomSheet((context) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  // bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
                child: BlocListener<NotesCubit, NotesState>(
                  listener: (context, state) {
                    if (state is AddNoteSucsess) {
                      BlocProvider.of<NotesCubit>(context).fetchAllNotes();

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
                        DefaultTextFormFiled(
                          onSaved: (value) {
                            title = value;
                          },
                          hint: 'Title',
                          maxline: 1,
                        ),
                        DefaultTextFormFiled(
                          onSaved: (value) {
                            content = value;
                          },
                          hint: 'Content',
                          maxline: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        backgroundColor: lightBlue,
        child: Icon(
          fabIcon,
          color: beige,
        ),
      ),
    );
  }
}

// class AddNoteBottomSheet extends StatelessWidget {
//   const AddNoteBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SingleChildScrollView(
//       padding: EdgeInsets.only(
//         right: 20,
//         left: 20,
//         // bottom: MediaQuery.of(context).viewInsets.bottom),
//       ),
//       child: AddNoteForm(),
//     );
//   }
// }

// class AddNoteForm extends StatefulWidget {
//   const AddNoteForm({
//     super.key,
//   });

//   @override
//   State<AddNoteForm> createState() => _AddNoteFormState();
// }

// class _AddNoteFormState extends State<AddNoteForm> {
//   final GlobalKey<FormState> formkey = GlobalKey();
//   String? title, content;
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formkey,
//       child: Column(
//         children: [
//          const SizedBox(
//             height: 20,
//           ),
//           DefaultTextFormFiled(
//             onSaved: (value) {
//               title = value;
//             },
//             hint: 'Title',
//             maxline: 1,
//           ),
//           DefaultTextFormFiled(
//             onSaved: (value) {
//               content = value;
//             },
//             hint: 'Content',
//             maxline: 8,
//           ),
//         ],
//       ),
//     );
//   }
// }
