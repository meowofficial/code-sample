part of 'use_case.dart';

sealed class LearningContentOuterUpdateHandlingResult {}

class NonexistentLexicalItemLearningContentOuterUpdateHandlingResult extends Equatable
    implements LearningContentOuterUpdateHandlingResult {
  const NonexistentLexicalItemLearningContentOuterUpdateHandlingResult({
    required this.lexicalItemDeleted,
    required this.lexicalItemMap,
  });

  final bool lexicalItemDeleted;
  final BuiltMap<String, LexicalItem> lexicalItemMap;

  @override
  List<Object?> get props {
    return [
      lexicalItemDeleted,
      lexicalItemMap,
    ];
  }
}

class SucceededLearningContentOuterUpdateHandlingResult extends Equatable
    implements LearningContentOuterUpdateHandlingResult {
  const SucceededLearningContentOuterUpdateHandlingResult({
    required this.currentFlowM,
    required this.nextFlowM,
    required this.lexicalItemMap,
  });

  final FlowM currentFlowM;
  final FlowM? nextFlowM;
  final BuiltMap<String, LexicalItem> lexicalItemMap;

  @override
  List<Object?> get props {
    return [
      currentFlowM,
      nextFlowM,
      lexicalItemMap,
    ];
  }
}
