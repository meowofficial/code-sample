part of 'use_case.dart';

sealed class LexicalItemAdditionToLearningQueueResult {}

class ActionNotPermittedLexicalItemAdditionToLearningQueueResult extends Equatable
    implements LexicalItemAdditionToLearningQueueResult {
  const ActionNotPermittedLexicalItemAdditionToLearningQueueResult({
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

class SucceededLexicalItemAdditionToLearningQueueResult extends Equatable
    implements LexicalItemAdditionToLearningQueueResult {
  const SucceededLexicalItemAdditionToLearningQueueResult({
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
