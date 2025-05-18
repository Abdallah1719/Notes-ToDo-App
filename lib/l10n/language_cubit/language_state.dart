
part of 'language_cubit.dart';

class LanguageState {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}