// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
// import 'package:notes/models/notes_model/notes_model.dart';
// import 'package:notes/presentation/screens/edit_screen.dart';
// import 'package:notes/styles/colors.dart';

// class NoteItem extends StatefulWidget {
//   const NoteItem({
//     super.key,
//     required this.note,
//   });

//   final NotesModel note;

//   @override
//   _NoteItemState createState() => _NoteItemState();
// }

// class _NoteItemState extends State<NoteItem> {
//   double _dragOffset = 0.0;
//   double _maxDragOffset = 0.0;
//   bool _isSwiped = false;

//   bool isArabic(String text) {
//     final arabicRegex = RegExp(r'[\u0600-\u06FF]');
//     return arabicRegex.hasMatch(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final date =
//         intl.DateFormat('dd/MM/yy').format(DateTime.parse(widget.note.date));
//     final isArabicText = isArabic(widget.note.title);

//     _maxDragOffset = MediaQuery.of(context).size.width * 0.5;

//     return GestureDetector(
//        onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => EditScreen(
//                       note: widget.note,
//                     )),
//           );
//         },
//       child: GestureDetector(
//         onHorizontalDragUpdate: (details) {
//           setState(() {
//             _dragOffset += details.primaryDelta!;
//             if (_dragOffset < -_maxDragOffset) {
//               _dragOffset = -_maxDragOffset;
//             } else if (_dragOffset > 0) {
//               _dragOffset = 0;
//             }
//           });
//         },
//         onHorizontalDragEnd: (details) {
//           setState(() {
//             if (_dragOffset <= -_maxDragOffset * 0.5) {
//               _dragOffset = -_maxDragOffset;
//               _isSwiped = true;
//             } else {
//               _dragOffset = 0.0;
//               _isSwiped = false;
//             }
//           });
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Stack(
//             children: [
//               Positioned(
//                 right: 0,
//                 top: 0,
//                 bottom: 0,
//                 width: _maxDragOffset, // نصف الشاشة
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(21),
//                   ),
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Row(mainAxisSize: MainAxisSize.max, children: [
//                     IconButton(
//                       onPressed: () {
//                         BlocProvider.of<NotesCubit>(context)
//                             .togglePinStatus(widget.note);
//                       },
//                       icon: Icon(
//                         widget.note.isPinned
//                             ? Icons.push_pin
//                             : Icons.push_pin_outlined,
//                         color: beige,
//                         size: 32,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         widget.note.delete();
//                         BlocProvider.of<NotesCubit>(context).fetchAllNotes();
//                         BlocProvider.of<NotesCubit>(context)
//                             .addSearchedForItemstoSearchedList('');
//                       },
//                       icon: const Icon(
//                         Icons.delete,
//                         size: 32,
//                       ),
//                       color: beige,
//                     ),
//                   ]),
//                 ),
//               ),
//               Transform.translate(
//                 offset: Offset(_dragOffset, 0),
//                 child: Container(
//                   padding: const EdgeInsets.only(top: 18, bottom: 18),
//                   decoration: BoxDecoration(
//                     color: darkBlue,
//                     borderRadius: BorderRadius.circular(21),
//                   ),
//                   child: Directionality(
//                     textDirection:
//                         isArabicText ? TextDirection.rtl : TextDirection.ltr,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         ListTile(
//                           contentPadding: EdgeInsets.only(
//                               left: isArabicText ? 5 : 20,
//                               right: isArabicText ? 20 : 5),
//                           title: Text(
//                             widget.note.title,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: const TextStyle(
//                                 color: beige,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           // trailing: Row(
      
//                           //   children: [
      
//                           //   ],
//                           // ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               right: isArabicText ? 0 : 20,
//                               left: isArabicText ? 20 : 0),
//                           child: Text(
//                             date,
//                             style: const TextStyle(
//                               color: beige,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
