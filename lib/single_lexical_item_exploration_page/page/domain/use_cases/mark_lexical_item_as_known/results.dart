part of 'use_case.dart';

sealed class LexicalItemMarkAsKnownResult {}

class ActionNotPermittedLexicalItemMarkAsKnownResult extends Equatable
    implements LexicalItemMarkAsKnownResult {
  const ActionNotPermittedLexicalItemMarkAsKnownResult({
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

class SucceededLexicalItemMarkAsKnownResult extends Equatable
    implements LexicalItemMarkAsKnownResult {
  const SucceededLexicalItemMarkAsKnownResult({
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
