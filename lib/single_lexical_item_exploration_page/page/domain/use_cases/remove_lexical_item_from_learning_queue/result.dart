part of 'use_case.dart';

class LexicalItemRemovalFromLearningQueueResult extends Equatable {
  const LexicalItemRemovalFromLearningQueueResult({
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
