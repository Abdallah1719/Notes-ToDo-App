// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
// import 'package:notes/presentation/shared/components.dart';

// class EditFormWidgets extends StatefulWidget {
//   const EditFormWidgets(this.bloc, {super.key});
//   final NotesCubit bloc;
//   @override
//   State<EditFormWidgets> createState() => _EditFormWidgetsState();
// }

// class _EditFormWidgetsState extends State<EditFormWidgets> {
//   late FocusNode titleFocusNode;
//   late FocusNode descFocusNode;

//   @override
//   void initState() {
//     titleFocusNode = FocusNode();
//     descFocusNode = FocusNode();
//     titleFocusNode.requestFocus();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     titleFocusNode.dispose();
//     descFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.only(
//         right: 20,
//         left: 20,
//       ),
//       child: BlocListener<NotesCubit, NotesState>(
//         listener: (context, state) {
//           if (state is AddNoteSucsess) {
//             BlocProvider.of<NotesCubit>(context).fetchAllNotes();
//             Navigator.pop(context);
//           }
//         },
//         child: Form(
//           key: widget.bloc.formkey,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               DefaultTextFormFiled(
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (String? text) {
//                   descFocusNode.requestFocus();
//                 },
//                 focusNode: titleFocusNode,
//                 onSaved: (value) {
//                  title = value;
//                 },
//                 hint: 'Title',
//                 maxline: 1,
//               ),
//               DefaultTextFormFiled(
//                 focusNode: descFocusNode,
//                 onSaved: (value) {
//                  content = value;
//                 },
//                 hint: 'Content',
//                 maxline: 8,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
