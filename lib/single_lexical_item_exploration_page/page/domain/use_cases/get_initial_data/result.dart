part of 'use_case.dart';

class InitialDataGettingResult extends Equatable {
  const InitialDataGettingResult({
    required this.currentFlowM,
    required this.nextFlowM,
    required this.flowTM,
    required this.lexicalItemDeleted,
    required this.lexicalItemMap,
  });

  final FlowM currentFlowM;
  final FlowM? nextFlowM;
  final FlowTM? flowTM;
  final bool lexicalItemDeleted;
  final BuiltMap<String, LexicalItem> lexicalItemMap;

  @override
  List<Object?> get props {
    return [
      currentFlowM,
      nextFlowM,
      flowTM,
      lexicalItemDeleted,
      lexicalItemMap,
    ];
  }
}
