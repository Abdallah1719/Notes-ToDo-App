import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/presentation/shared/components.dart';
import 'package:notes/presentation/widgets/notes_widgets/note_search.dart';
import 'package:notes/presentation/widgets/notes_widgets/notes_body.dart';
import 'package:notes/presentation/widgets/shared_widgets/drawer_content.dart';
import 'package:notes/styles/colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  var scaffoldKye = GlobalKey<ScaffoldState>();

  late FocusNode titleFocusNode;
  late FocusNode descFocusNode;

  @override
  void initState() {
    titleFocusNode = FocusNode();
    descFocusNode = FocusNode();
    titleFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    descFocusNode.dispose();
    super.dispose();
  }

  String? title, content;
  void startSearching() {
    isSearching = true;
    setState(() {});
  }

  void stopSearching() {
    BlocProvider.of<NotesCubit>(context).searchTextController.clear();
    BlocProvider.of<NotesCubit>(context).searchedForNote.clear();
    isSearching = false;
    setState(() {});
  }

  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotesCubit>(context);
    return BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKye,
            drawer: const Drawer(
              child: DrawerContent(),
            ),
            appBar: AppBar(
              backgroundColor: darkBlue,
              title: isSearching
                  ? null
                  : Text(
                      S.of(context).title,
                      style:
                          TextStyle(color: beige, fontWeight: FontWeight.bold),
                    ),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                    ),
                    color: beige,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: [
                !isSearching
                    ? IconButton(
                        onPressed: () {
                          startSearching();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: beige,
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Search()),
                if (isSearching)
                  IconButton(
                    onPressed: () {
                      stopSearching();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: beige,
                    ),
                  )
              ],
            ),
            body: NotesBody(
              isSearcing: isSearching,
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              onPressed: () {
                if (bloc.isBottomSheetShown) {
                  if (bloc.formkey.currentState!.validate()) {
                    bloc.formkey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formatcurrentDate = currentDate.toIso8601String();
                    // DateFormat('dd/MM/yy').format(currentDate);
                    var notemodel = NotesModel(
                  
                      title: title ?? '',
                      subtitle: content ?? '',
                      date: formatcurrentDate,
                    );
                    BlocProvider.of<NotesCubit>(context).addNote(notemodel);

                    bloc.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  }
                } else {
                  scaffoldKye.currentState
                      ?.showBottomSheet(backgroundColor: Colors.grey[300],
                          (context) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          child: BlocListener<NotesCubit, NotesState>(
                            listener: (context, state) {
                              if (state is AddNoteSucsess) {
                                BlocProvider.of<NotesCubit>(context)
                                    .fetchAllNotes();
                                Navigator.pop(context);
                              }
                            },
                            child: Form(
                              key: bloc.formkey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultTextFormFiled(
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String? text) {
                                      descFocusNode.requestFocus();
                                    },
                                    focusNode: titleFocusNode,
                                    onSaved: (value) {
                                      title = value;
                                    },
                                    hint: 'Title',
                                    maxline: 1,
                                  ),
                                  DefaultTextFormFiled(
                                    focusNode: descFocusNode,
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
                      })
                      .closed
                      .then((value) {
                        bloc.changeBottomSheetState(
                            isShow: false, icon: Icons.edit);
                      });

                  bloc.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              backgroundColor: darkBlue,
              child: Icon(
                bloc.fabIcon,
                color: beige,
              ),
            ),
          );
        });
  }
}
