part of 'bloc.dart';

class SingleLexicalItemPageBlocState {
  const SingleLexicalItemPageBlocState({
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

  SingleLexicalItemPageBlocState copyWith({
    FlowM Function()? currentFlowM,
    FlowM? Function()? nextFlowM,
    FlowTM? Function()? flowTM,
    bool Function()? lexicalItemDeleted,
    BuiltMap<String, LexicalItem> Function()? lexicalItemMap,
  }) {
    return SingleLexicalItemPageBlocState(
      currentFlowM: currentFlowM == null ? this.currentFlowM : currentFlowM(),
      nextFlowM: nextFlowM == null ? this.nextFlowM : nextFlowM(),
      flowTM: flowTM == null ? this.flowTM : flowTM(),
      lexicalItemDeleted:
          lexicalItemDeleted == null ? this.lexicalItemDeleted : lexicalItemDeleted(),
      lexicalItemMap: lexicalItemMap == null ? this.lexicalItemMap : lexicalItemMap(),
    );
  }
}
