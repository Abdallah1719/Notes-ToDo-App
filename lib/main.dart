import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/core/theme/cubit/theme_cubit.dart';
import 'package:notes/l10n/language_cubit/language_cubit.dart';
import 'package:notes/features/notes/presentation/controller/notes_cubits/cubit/notes_cubit.dart';
import 'package:notes/features/todo/presentation/controller/to_do_cubits/cubit/to_do_cubit.dart';
import 'package:notes/core/utils/constant.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/generated/l10n.dart';
import 'package:notes/features/notes/data/notes_model/notes_model.dart';
import 'package:notes/features/todo/data/to_do_model/to_do_model.dart';
import 'package:notes/features/notes/presentation/screens/notes_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:notes/core/theme/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>(knotesBox);
  await Hive.openBox<ToDoModel>(ktodoBox);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Notes());
  FlutterNativeSplash.remove();
}

class Notes extends StatelessWidget {
  const Notes({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => NotesCubit()),
        BlocProvider(create: (context) => ToDoCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          analytics.setAnalyticsCollectionEnabled(true);
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                navigatorObservers: [observer],
                locale: languageState.locale,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                home: const NotesScreen(),
                theme: AppThemes.lightTheme, 
                darkTheme: AppThemes.darkTheme, 
                themeMode: themeState.themeMode,
                navigatorKey: navigatorKey,
              );
            },
          );
        },
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
