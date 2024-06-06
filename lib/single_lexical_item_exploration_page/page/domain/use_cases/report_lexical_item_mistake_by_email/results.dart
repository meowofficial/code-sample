part of 'use_case.dart';

sealed class LexicalItemMistakeReportByEmailResult {}

class EmailAppSelectionRequiredLexicalItemMistakeReportByEmailResult extends Equatable
    implements LexicalItemMistakeReportByEmailResult {
  const EmailAppSelectionRequiredLexicalItemMistakeReportByEmailResult({
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

class SucceededLexicalItemMistakeReportByEmailResult extends Equatable
    implements LexicalItemMistakeReportByEmailResult {
  const SucceededLexicalItemMistakeReportByEmailResult();

  @override
  List<Object?> get props => [];
}
