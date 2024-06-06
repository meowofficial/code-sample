part of 'dialog.dart';

class _CardActionDialogTranslation extends AppTranslation {
  const _CardActionDialogTranslation({
    required super.uiLocale,
  });

  static const delegate = _CardActionDialogTranslationDelegate();

  static _CardActionDialogTranslation of(BuildContext context) {
    return Localizations.of(context, _CardActionDialogTranslation);
  }

  String get deletionCardActionTitle {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Стереть';

      case UiLocale.en:
        return 'Erase';
    }
  }
}

class _CardActionDialogTranslationDelegate
    extends AppLocalizationsDelegate<_CardActionDialogTranslation> {
  const _CardActionDialogTranslationDelegate();

  @override
  SynchronousFuture<_CardActionDialogTranslation> load(Locale locale) {
    final uiLocale = localeToUiLocale(locale)!;

    final translation = _CardActionDialogTranslation(
      uiLocale: uiLocale,
    );

    return SynchronousFuture(translation);
  }
}
