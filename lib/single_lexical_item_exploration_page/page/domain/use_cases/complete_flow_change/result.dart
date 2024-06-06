part of 'use_case.dart';

class FlowChangeCompletionResult extends Equatable {
  const FlowChangeCompletionResult({
    required this.currentFlowM,
    required this.nextFlowM,
    required this.flowTM,
  });

  final FlowM currentFlowM;
  final FlowM? nextFlowM;
  final FlowTM? flowTM;

  @override
  List<Object?> get props {
    return [
      currentFlowM,
      nextFlowM,
      flowTM,
    ];
  }
}
