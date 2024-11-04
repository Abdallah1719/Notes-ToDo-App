import 'package:flutter/material.dart';
import 'package:notes/presentation/screens/notes_screen.dart';
import 'package:notes/presentation/screens/to_do_screen.dart';
import 'package:notes/styles/colors.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        // ElevatedButton(
        //   child: Row(
        //     children: [
        //       Icon(Icons.fork_right),
        //       Text('ToDo'),
        //     ],
        //   ),
        //   iconAlignment: IconAlignment.start,
        //   style: ButtonStyle(),
        //   onPressed: null,
        // ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.add_circle,
            color: beige,
          ),
          onHover: (value) {},
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotesScreen()),
            );
          },
          label: const Text(
            "Notes",
            style: TextStyle(fontSize: 16, color: beige),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            fixedSize: const Size(208, 43),
            overlayColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.add_circle,
            color: beige,
          ),
          onHover: (value) {},
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TodoScreen()),
            );
          },
          label: const Text(
            "TO Do",
            style: TextStyle(fontSize: 16, color: beige),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            fixedSize: const Size(208, 43),
            overlayColor: Colors.white,
          ),
        )
      ],
    );
  }
}
