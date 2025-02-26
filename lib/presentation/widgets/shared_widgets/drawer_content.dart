import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/business_logic/cubit/theme_cubit.dart';
import 'package:notes/business_logic/language_cubit/language_cubit.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/presentation/screens/to_do_screen.dart';
import 'package:notes/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // log('${ModalRoute.of(context)?.settings.name}');
            if (ModalRoute.of(context)?.settings.name == null) {
              Navigator.popUntil(context, (predicate) {
                return predicate.settings.name == '/';
              });
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }
          },
          label: Text(
            S.of(context).notes_title,
            style: TextStyle(fontSize: 16, color: beige),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            fixedSize: const Size(208, 43),
            overlayColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
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
          label: Text(
            S.of(context).to_do_title,
            style: TextStyle(fontSize: 16, color: beige),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            fixedSize: const Size(208, 43),
            overlayColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        ElevatedButton.icon(
          icon: const Icon(
            Icons.language,
            color: beige,
          ),
          onHover: (value) {},
          onPressed: () {
            // final currentLanguage =
            //     context.read<LanguageCubit>().state.languageCode;
            // final newLanguage = currentLanguage == 'en' ? 'ar' : 'en';
            // context.read<LanguageCubit>().changeLanguage(newLanguage);
            final currentLocale = context.read<LanguageCubit>().state.locale;

            // تحديد اللغة الجديدة
            final newLanguage =
                currentLocale.languageCode == 'en' ? 'ar' : 'en';

            // تغيير اللغة
            context.read<LanguageCubit>().changeLanguage(newLanguage);
          },
          label: Text(
            S.of(context).language,
            style: TextStyle(fontSize: 16, color: beige),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            fixedSize: const Size(208, 43),
            overlayColor: Colors.white,
          ),
        ),

        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.link,
            color: beige,
          ),
          onHover: (value) {},
          onPressed: () {
            _launchUrl();
          },
          label: Text(
            S.of(context).privacy_policy,
            style: TextStyle(fontSize: 16, color: beige),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            fixedSize: const Size(208, 43),
            overlayColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        // ElevatedButton.icon(
        //   icon: const Icon(
        //     Icons.brightness_6,
        //     color: beige,
        //   ),
        //   onHover: (value) {},
        //   onPressed: () {
        //     context.read<ThemeCubit>().toggleTheme();
        //   },
        //   label: Text(
        //     'theme',
        //     style: TextStyle(fontSize: 16, color: beige),
        //   ),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: darkBlue,
        //     fixedSize: const Size(208, 43),
        //     overlayColor: Colors.white,
        //   ),
        // ),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final isDarkTheme = themeState.themeMode == ThemeMode.dark;

            return ElevatedButton.icon(
              icon: Icon(
                isDarkTheme
                    ? Icons.light_mode
                    : Icons.dark_mode, // تغيير الأيقونة بناءً على الثيم
                color: beige,
              ),
              onHover: (value) {},
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme(); // تغيير الثيم
              },
              label: Text(
                isDarkTheme
                    ? 'Light Theme'
                    : 'Dark Theme', // تغيير النص بناءً على الثيم
                style: TextStyle(fontSize: 16, color: beige),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                fixedSize: const Size(208, 43),
                overlayColor: Colors.white,
              ),
            );
          },
        )
      ],
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(
        'https://www.termsfeed.com/live/a1e18794-fae7-4bd5-8442-fafd16578812'))) {
      throw Exception(
          'Could not launch https://www.termsfeed.com/live/a1e18794-fae7-4bd5-8442-fafd16578812');
    }
  }
}
