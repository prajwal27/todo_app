import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class AppStrings {
  AppStrings({this.locale});

  final Locale locale;

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings);
  }

  static const _AppStringsDelegate delegate = _AppStringsDelegate();

  static List<LocalizationsDelegate<Object>> delegates =
      <LocalizationsDelegate<Object>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    delegate,
  ];

  static const Locale english = Locale('en');
  static const Locale spanish = Locale('es');

  static const List<Locale> supportedLocales = <Locale>[
    english,
    spanish,
  ];

  static const String _title = 'title';

  static const String _desc = 'desc';
  static const String _environment = 'environment';
  static const String _times = 'times';
  static const String _switchTo = 'switchTo';

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    'en': <String, String>{
      _title: 'Flutter Demo',
      _environment: 'Environment',
      _desc: 'You have pressed the button ',
      _times: 'times',
      _switchTo: 'Switch To',
    },
    'es': <String, String>{
      _title: 'Flutter Manifestación',
      _environment: 'Ambiente',
      _desc: 'Has pulsado el botón ',
      _times: 'veces',
      _switchTo: 'Cambiar a',
    },
  };

  String get switchTo {
    return _localizedValues[locale.languageCode][_switchTo];
  }

  String get title {
    return _localizedValues[locale.languageCode][_title];
  }

  String get environment {
    return _localizedValues[locale.languageCode][_environment];
  }

  String get description {
    return _localizedValues[locale.languageCode][_desc];
  }

  String get times {
    return _localizedValues[locale.languageCode][_times];
  }
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppStrings.supportedLocales.firstWhere(
          (Locale l) => l.languageCode == locale.languageCode,
          orElse: () => null,
        ) !=
        null;
  }

  @override
  Future<AppStrings> load(Locale locale) {
    AppStrings strings;
    if (locale.languageCode == 'en') {
      strings = EnglishStrings();
    } else if (locale.languageCode == 'es') {
      strings = SpanishStrings();
    }

    return SynchronousFuture<AppStrings>(strings);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppStrings> old) => false;
}

class EnglishStrings extends AppStrings {
  EnglishStrings() : super(locale: AppStrings.english);
}

class SpanishStrings extends AppStrings {
  SpanishStrings() : super(locale: AppStrings.spanish);
}
