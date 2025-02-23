import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/business_logic/language_cubit/language_cubit.dart';
import 'package:notes/business_logic/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/business_logic/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/constant.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/models/notes_model/notes_model.dart';
import 'package:notes/models/to_do_model/to_do_model.dart';
import 'package:notes/presentation/screens/notes_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'presentation/shared/bloc_observer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>(knotesBox);
  await Hive.openBox<ToDoModel>(ktodoBox);
  runApp(const Notes());
  FlutterNativeSplash.remove();
}

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(create: (context) => NotesCubit()),
        BlocProvider(create: (context) => ToDoCubit()),
      ],
      child:BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            locale: Locale(state.languageCode),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: const NotesScreen(),
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// S.of(context).test
// dart run change_app_package_name:main com.notes.todo --ios
