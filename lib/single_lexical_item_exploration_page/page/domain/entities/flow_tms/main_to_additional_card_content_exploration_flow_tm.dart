part of 'flow_tm.dart';

class MainToAdditionalCardContentExplorationFlowTM extends Equatable implements FlowTM {
  const MainToAdditionalCardContentExplorationFlowTM({
    required this.method,
  });

  final CardAdditionalContentRevealingMethod method;

  @override
  List<Object?> get props {
    return [
      method,
    ];
  }
}
