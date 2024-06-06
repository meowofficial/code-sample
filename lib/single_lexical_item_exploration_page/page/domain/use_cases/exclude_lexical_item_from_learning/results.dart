part of 'use_case.dart';

sealed class LexicalItemExclusionFromLearningResult {}

class ActionNotPermittedLexicalItemExclusionFromLearningResult extends Equatable
    implements LexicalItemExclusionFromLearningResult {
  const ActionNotPermittedLexicalItemExclusionFromLearningResult({
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

class SucceededLexicalItemExclusionFromLearningResult extends Equatable
    implements LexicalItemExclusionFromLearningResult {
  const SucceededLexicalItemExclusionFromLearningResult({
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
