import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/presentation/controller/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/features/notes/data/notes_model/notes_model.dart';
import 'package:notes/features/notes/presentation/notes_widgets/note_color_listview.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.note});
  final NotesModel note;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String? title, content;
  late Color selectedColor;

  
  TextDirection getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]'); 
    return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  void initState() {
    super.initState();
  
    selectedColor = Color(widget.note.color ?? 0xff55DDE0);
    contentFocusNode = FocusNode();
  }

  late FocusNode contentFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          S.of(context).edit_note_title,
          style: Theme.of(context).textTheme.titleLarge,
          textDirection: getTextDirection(
              widget.note.title), 
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.note.title = title ?? widget.note.title;
              widget.note.subtitle = content ?? widget.note.subtitle;
              widget.note.color = selectedColor.value; 
              widget.note.save();
              final bloc = BlocProvider.of<NotesCubit>(context);
              bloc.fetchAllNotes();

              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
      body: Container(
        color: selectedColor,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    cursorColor: Theme.of(context).hintColor,
                    controller: TextEditingController(text: widget.note.title),
                    maxLines: 1,
                    onChanged: (value) {
                      title = value;
                    },
                    textDirection: getTextDirection(widget.note.title),
                    decoration: InputDecoration(
                        hintText: S.of(context).title_hint,
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        border: InputBorder.none),
                    onSubmitted: (String? title) {
                      contentFocusNode.requestFocus();
                    },
                  ),
                  TextField(
                    cursorColor: Theme.of(context).hintColor,
                    focusNode: contentFocusNode,
                    controller:
                        TextEditingController(text: widget.note.subtitle),
                    maxLines: 5,
                    onChanged: (value) {
                      content = value;
                    },
                    textDirection: getTextDirection(widget.note.subtitle),
                    decoration: InputDecoration(
                        hintText: S.of(context).content_hint,
                        hintStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        border: InputBorder.none),
                  ),
                  const SizedBox(height: 20),
               
                  ColorsListView(
                    onColorSelected: (color) {
                      setState(() {
                        selectedColor = color; 
                      });
                    },
                    initialColor: selectedColor, 
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
