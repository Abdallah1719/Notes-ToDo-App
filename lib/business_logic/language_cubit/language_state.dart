part of 'language_cubit.dart';

class LanguageState {
  final String languageCode;

  const LanguageState(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}