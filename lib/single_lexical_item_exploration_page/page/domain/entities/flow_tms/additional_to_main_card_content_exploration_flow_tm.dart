part of 'flow_tm.dart';

class AdditionalToMainCardContentExplorationFlowTM extends Equatable implements FlowTM {
  const AdditionalToMainCardContentExplorationFlowTM({
    required this.method,
  });

  final CardAdditionalContentClosingMethod method;

  @override
  List<Object?> get props {
    return [
      method,
    ];
  }
}
