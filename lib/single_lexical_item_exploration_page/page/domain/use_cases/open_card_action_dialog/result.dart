part of 'use_case.dart';

class CardActionDialogOpeningResult extends Equatable {
  const CardActionDialogOpeningResult({
    required this.notification,
  });

  final SingleLexicalItemPageNotification notification;

  @override
  List<Object?> get props {
    return [
      notification,
    ];
  }
}
