part of 'view.dart';

class _AllLexicalItemExplorationPageTranslation extends AppTranslation {
  const _AllLexicalItemExplorationPageTranslation({
    required super.uiLocale,
  });

  static const delegate = _AllLexicalItemExplorationPageTranslationDelegate();

  static _AllLexicalItemExplorationPageTranslation of(BuildContext context) {
    return Localizations.of(context, _AllLexicalItemExplorationPageTranslation);
  }

  String get title {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Все слова';

      case UiLocale.en:
        return 'All words';
    }
  }

  String buildLexicalItemTileGroupHeader({
    required int lexicalItemCount,
  }) {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Слова ($lexicalItemCount)';

      case UiLocale.en:
        return 'Words ($lexicalItemCount)';
    }
  }
}

class _AllLexicalItemExplorationPageTranslationDelegate
    extends AppLocalizationsDelegate<_AllLexicalItemExplorationPageTranslation> {
  const _AllLexicalItemExplorationPageTranslationDelegate();

  @override
  SynchronousFuture<_AllLexicalItemExplorationPageTranslation> load(Locale locale) {
    final uiLocale = localeToUiLocale(locale)!;

    final translation = _AllLexicalItemExplorationPageTranslation(
      uiLocale: uiLocale,
    );

    return SynchronousFuture(translation);
  }
}
