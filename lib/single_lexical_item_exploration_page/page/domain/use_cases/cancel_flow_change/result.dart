part of 'use_case.dart';

class FlowChangeCancellationResult extends Equatable {
  const FlowChangeCancellationResult({
    required this.nextFlowM,
    required this.flowTM,
  });

  final FlowM? nextFlowM;
  final FlowTM? flowTM;

  @override
  List<Object?> get props {
    return [
      nextFlowM,
      flowTM,
    ];
  }
}
