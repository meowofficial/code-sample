part of 'use_case.dart';

class AdditionalContentRevealingResult extends Equatable {
  const AdditionalContentRevealingResult({
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
