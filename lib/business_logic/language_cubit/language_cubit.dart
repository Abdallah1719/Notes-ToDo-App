// import 'package:bloc/bloc.dart';

// part 'language_state.dart';
// class LanguageCubit extends Cubit<LanguageState> {
//   LanguageCubit() : super(const LanguageState('en'));

//   void changeLanguage(String languageCode) {
//     emit(LanguageState(languageCode));
//   }
// }

// part of 'language_cubit.dart';

// class LanguageState {
//   final Locale locale; // استخدام Locale بدلاً من languageCode

//   const LanguageState(this.locale);

//   @override
//   List<Object> get props => [locale];
// }

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('en'))); // اللغة الافتراضية (الإنجليزية)

  void changeLanguage(String languageCode) {
    emit(LanguageState(Locale(languageCode))); // تغيير اللغة باستخدام Locale
  }
}