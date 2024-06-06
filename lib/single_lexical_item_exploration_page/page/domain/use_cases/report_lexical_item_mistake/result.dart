part of 'use_case.dart';

class LexicalItemMistakeReportResult extends Equatable {
  const LexicalItemMistakeReportResult({
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
