// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
// import 'package:notes/models/notes_model/notes_model.dart';
// import 'package:notes/presentation/shared/components.dart';
// import 'package:notes/styles/colors.dart';

// class EditScreen extends StatefulWidget {
//   const EditScreen({super.key, required this.note});
//   final NotesModel note;

//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }

// class _EditScreenState extends State<EditScreen> {
//   String? title, content;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: beige),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: darkBlue,
//         title: const Text(
//           'Edit Note',
//           style: TextStyle(
//               color: beige, fontSize: 32, fontWeight: FontWeight.w700),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               widget.note.title = title ?? widget.note.title;
//               widget.note.subtitle = content ?? widget.note.subtitle;
//               widget.note.save();
//               final bloc = BlocProvider.of<NotesCubit>(context);
//               bloc.fetchAllNotes();
//               log('FETCHED');
//               // setState(() {});
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.check),
//             color: beige,
//           ),
//         ],
//       ),
//       body: Container(
//         color: Colors.grey[300],
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   DefaultTextFormFiled(
//                     controller: TextEditingController(text: widget.note.title),
//                     maxline: 1,
//                     onChanged: (value) {
//                       title = value;
//                     },
//                     hint: 'Title',
//                   ),
//                   DefaultTextFormFiled(
//                     controller:
//                         TextEditingController(text: widget.note.subtitle),
//                     maxline: 5,
//                     onChanged: (value) {
//                       content = value;
//                     },
//                     hint: 'Content',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/styles/colors.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.note});
  final NotesModel note;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String? title, content;

  // دالة لتحديد اتجاه النص (rtl للعربية، ltr للإنجليزية)
  TextDirection getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]'); // نطاق الحروف العربية
    return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: beige),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: darkBlue,
        title: Text(
          'Edit Note',
          style: const TextStyle(
              color: beige, fontSize: 32, fontWeight: FontWeight.w700),
          textDirection: getTextDirection(
              widget.note.title), // تحديد الاتجاه بناءً على العنوان
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.note.title = title ?? widget.note.title;
              widget.note.subtitle = content ?? widget.note.subtitle;
              widget.note.save();
              final bloc = BlocProvider.of<NotesCubit>(context);
              bloc.fetchAllNotes();

              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
            color: beige,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(text: widget.note.title),
                    maxLines: 1,
                    onChanged: (value) {
                      title = value;
                    },
                    textDirection: getTextDirection(
                        widget.note.title), // تحديد الاتجاه بناءً على العنوان
                    decoration: InputDecoration(
                      // hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller:
                        TextEditingController(text: widget.note.subtitle),
                    maxLines: 5,
                    onChanged: (value) {
                      content = value;
                    },
                    textDirection: getTextDirection(widget
                        .note.subtitle), // تحديد الاتجاه بناءً على المحتوى
                    decoration: InputDecoration(
                      // hintText: 'Content',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
