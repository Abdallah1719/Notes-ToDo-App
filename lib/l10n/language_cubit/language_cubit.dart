import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('en')));

  void changeLanguage(String languageCode) {
    emit(LanguageState(Locale(languageCode))); 
  }
}