part of 'dialog.dart';

class _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation extends AppTranslation {
  const _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation({
    required super.uiLocale,
  });

  static const delegate = _OrphanCustomLexicalItemDeletionConfirmationDialogTranslationDelegate();

  static _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation of(BuildContext context) {
    return Localizations.of(context, _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation);
  }

  String get message {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Ты действительно хочешь стереть это слово?';

      case UiLocale.en:
        return 'Are you sure you want to erase this word?';
    }
  }

  String get confirmationAnswer {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Стереть';

      case UiLocale.en:
        return 'Erase';
    }
  }
}

class _OrphanCustomLexicalItemDeletionConfirmationDialogTranslationDelegate
    extends AppLocalizationsDelegate<
        _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation> {
  const _OrphanCustomLexicalItemDeletionConfirmationDialogTranslationDelegate();

  @override
  SynchronousFuture<_OrphanCustomLexicalItemDeletionConfirmationDialogTranslation> load(
      Locale locale) {
    final uiLocale = localeToUiLocale(locale)!;

    final translation = _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation(
      uiLocale: uiLocale,
    );

    return SynchronousFuture(translation);
  }
}
