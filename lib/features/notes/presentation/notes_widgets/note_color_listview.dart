
import 'package:flutter/material.dart';
import 'package:notes/features/notes/presentation/notes_widgets/note_color_item.dart';

class ColorsListView extends StatefulWidget {
  final Function(Color) onColorSelected; 
  final Color initialColor;

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
                  widget.onColorSelected(colors[index]); 
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
