// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
// import 'package:notes/presentation/widgets/notes_widgets/note_color_item.dart';

// class ColorsListView extends StatefulWidget {
//   const ColorsListView({super.key});

//   @override
//   State<ColorsListView> createState() => _ColorsListViewState();
// }

// class _ColorsListViewState extends State<ColorsListView> {
//   int currentIndex = 0;
//   List<Color> colors = [
//     Color(0xffD30C7B),
//     Color(0xffFFE3DC),
//     Color(0xffDBB4AD),
//     Color(0xffA2AD91),
//     Color(0xff3A2D32),
//     Color(0xff3B0086),
//     Color(0xff6200B3),
//     Color(0xffB43E8F),
//     Color(0xffF26419),
//     Color(0xff33658A),
//     Color(0xff55DDE0),
//     Color(0xffF6AE2D),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 26 * 2,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: colors.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               child: GestureDetector(
//                 onTap: () {
//                   currentIndex = index;
//                   BlocProvider.of<NotesCubit>(context).color = colors[index];
//                   setState(() {});
//                 },
//                 child: ColorItem(
//                   color: colors[index],
//                   isActive: currentIndex == index,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:notes/presentation/widgets/notes_widgets/note_color_item.dart';

class ColorsListView extends StatefulWidget {
  final Function(Color) onColorSelected; // دالة لتحديث اللون
  final Color initialColor; // اللون المبدئي

  const ColorsListView({
    super.key,
    required this.onColorSelected,
    required this.initialColor,
  });

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  int currentIndex = 0;
  List<Color> colors = [
    Color(0xffD30C7B),
    Color(0xffFFE3DC),
    Color(0xffDBB4AD),
    Color(0xffA2AD91),
    Color(0xff3A2D32),
    Color(0xff3B0086),
    Color(0xff6200B3),
    Color(0xffB43E8F),
    Color(0xffF26419),
    Color(0xff33658A),
    Color(0xff55DDE0),
    Color(0xffF6AE2D),
  ];

  @override
  void initState() {
    super.initState();
    // تعيين اللون المبدئي عند فتح الصفحة
    currentIndex = colors.indexOf(widget.initialColor);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26 * 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  widget.onColorSelected(colors[index]); // تحديث اللون المحدد
                },
                child: ColorItem(
                  color: colors[index],
                  isActive: currentIndex == index,
                ),
              ),
            );
          }),
    );
  }
}