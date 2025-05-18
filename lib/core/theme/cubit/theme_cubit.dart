import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
    _loadTheme();
  }

  // دالة لتحميل الثيم المحفوظ
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  // دالة للتبديل بين الثيمات وحفظ الحالة
  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.themeMode == ThemeMode.light) {
      emit(ThemeState(themeMode: ThemeMode.dark));
      prefs.setBool('isDark', true);
    } else {
      emit(ThemeState(themeMode: ThemeMode.light));
      prefs.setBool('isDark', false);
    }
  }
}