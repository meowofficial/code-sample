part of 'view.dart';

class _SingleLexicalItemPageTranslation extends AppTranslation {
  const _SingleLexicalItemPageTranslation({
    required super.uiLocale,
  });

  static const delegate = _SingleLexicalItemPageTranslationDelegate();

  static _SingleLexicalItemPageTranslation of(BuildContext context) {
    return Localizations.of(context, _SingleLexicalItemPageTranslation);
  }

  String get title {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Карточка слова';

      case UiLocale.en:
        return 'Word card';
    }
  }
}

class _SingleLexicalItemPageTranslationDelegate
    extends AppLocalizationsDelegate<_SingleLexicalItemPageTranslation> {
  const _SingleLexicalItemPageTranslationDelegate();

  @override
  SynchronousFuture<_SingleLexicalItemPageTranslation> load(Locale locale) {
    final uiLocale = localeToUiLocale(locale)!;

    final translation = _SingleLexicalItemPageTranslation(
      uiLocale: uiLocale,
    );

    return SynchronousFuture(translation);
  }
}
