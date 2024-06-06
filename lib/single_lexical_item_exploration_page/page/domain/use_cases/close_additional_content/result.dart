part of 'use_case.dart';

class AdditionalContentClosingResult extends Equatable {
  const AdditionalContentClosingResult({
    required this.nextFlowM,
    required this.flowTM,
  });

  final FlowM? nextFlowM;
  final FlowTM flowTM;

  @override
  List<Object?> get props {
    return [
      nextFlowM,
      flowTM,
    ];
  }
}
