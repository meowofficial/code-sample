part of 'dialog.dart';

class _UsedCustomLexicalItemDeletionConfirmationDialogTranslation extends AppTranslation {
  const _UsedCustomLexicalItemDeletionConfirmationDialogTranslation({
    required super.uiLocale,
  });

  static const delegate = _UsedCustomLexicalItemDeletionConfirmationDialogTranslationDelegate();

  static _UsedCustomLexicalItemDeletionConfirmationDialogTranslation of(BuildContext context) {
    return Localizations.of(context, _UsedCustomLexicalItemDeletionConfirmationDialogTranslation);
  }

  String get message {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Это слово содержится в твоих коллекциях. '
            'Ты действительно хочешь удалить его из всех коллекций и стереть?';

      case UiLocale.en:
        return 'This word is contained in the your collections. '
            'Are you sure you want remove it from all collections and erase?';
    }
  }

  String get confirmationAnswer {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Удалить из всех коллекций и стереть';

      case UiLocale.en:
        return 'Remove from all collections and erase';
    }
  }
}

class _UsedCustomLexicalItemDeletionConfirmationDialogTranslationDelegate
    extends AppLocalizationsDelegate<_UsedCustomLexicalItemDeletionConfirmationDialogTranslation> {
  const _UsedCustomLexicalItemDeletionConfirmationDialogTranslationDelegate();

  @override
  SynchronousFuture<_UsedCustomLexicalItemDeletionConfirmationDialogTranslation> load(
      Locale locale) {
    final uiLocale = localeToUiLocale(locale)!;

    final translation = _UsedCustomLexicalItemDeletionConfirmationDialogTranslation(
      uiLocale: uiLocale,
    );

    return SynchronousFuture(translation);
  }
}
