// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Notes`
  String get notes_title {
    return Intl.message(
      'Notes',
      name: 'notes_title',
      desc: '',
      args: [],
    );
  }

  /// `To Do`
  String get to_do_title {
    return Intl.message(
      'To Do',
      name: 'to_do_title',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks_label {
    return Intl.message(
      'Tasks',
      name: 'tasks_label',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done_label {
    return Intl.message(
      'Done',
      name: 'done_label',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get archived_label {
    return Intl.message(
      'Archived',
      name: 'archived_label',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get task_title_label {
    return Intl.message(
      'Task Title',
      name: 'task_title_label',
      desc: '',
      args: [],
    );
  }

  /// `Task Time`
  String get task_time_label {
    return Intl.message(
      'Task Time',
      name: 'task_time_label',
      desc: '',
      args: [],
    );
  }

  /// `Task Date`
  String get task_date_label {
    return Intl.message(
      'Task Date',
      name: 'task_date_label',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title_hint {
    return Intl.message(
      'Title',
      name: 'title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content_hint {
    return Intl.message(
      'Content',
      name: 'content_hint',
      desc: '',
      args: [],
    );
  }

  /// `search notes`
  String get search_hint_text {
    return Intl.message(
      'search notes',
      name: 'search_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Edit Note`
  String get edit_note_title {
    return Intl.message(
      'Edit Note',
      name: 'edit_note_title',
      desc: '',
      args: [],
    );
  }

  /// `Add Notes First`
  String get add_notes_first {
    return Intl.message(
      'Add Notes First',
      name: 'add_notes_first',
      desc: '',
      args: [],
    );
  }

  /// `Add First Task`
  String get add_first_task {
    return Intl.message(
      'Add First Task',
      name: 'add_first_task',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
