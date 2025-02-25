import 'package:bloc/bloc.dart';

part 'language_state.dart';
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState('en'));

  void changeLanguage(String languageCode) {
    emit(LanguageState(languageCode));
  }
}