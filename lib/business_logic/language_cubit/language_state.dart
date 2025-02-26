// part of 'language_cubit.dart';

// class LanguageState {
//   final String languageCode;

//   const LanguageState(this.languageCode);

//   @override
//   List<Object> get props => [languageCode];
// }

part of 'language_cubit.dart';

class LanguageState {
  final Locale locale; // استخدام Locale بدلاً من languageCode

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}