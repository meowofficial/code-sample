part of 'use_case.dart';

sealed class LexicalItemMarkAsCompletelyLearnedResult {}

class ActionNotPermittedLexicalItemMarkAsCompletelyLearnedResult extends Equatable
    implements LexicalItemMarkAsCompletelyLearnedResult {
  const ActionNotPermittedLexicalItemMarkAsCompletelyLearnedResult({
    required this.notification,
  });

  final PurchasePageOpeningNotification notification;

  @override
  List<Object?> get props {
    return [
      notification,
    ];
  }
}

class SucceededLexicalItemMarkAsCompletelyLearnedResult extends Equatable
    implements LexicalItemMarkAsCompletelyLearnedResult {
  const SucceededLexicalItemMarkAsCompletelyLearnedResult({
    required this.currentFlowM,
    required this.lexicalItemMap,
    required this.shouldShowSuccessIndicator,
  });

  final FlowM currentFlowM;
  final BuiltMap<String, LexicalItem> lexicalItemMap;
  final bool shouldShowSuccessIndicator;

  @override
  List<Object?> get props {
    return [
      currentFlowM,
      lexicalItemMap,
      shouldShowSuccessIndicator,
    ];
  }
}
