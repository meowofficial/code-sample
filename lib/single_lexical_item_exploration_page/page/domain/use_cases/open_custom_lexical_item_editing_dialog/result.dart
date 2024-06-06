part of 'use_case.dart';

class CustomLexicalItemEditingDialogOpeningResult extends Equatable {
  const CustomLexicalItemEditingDialogOpeningResult({
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
