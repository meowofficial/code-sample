part of 'flow_pm.dart';

class AdditionalCardContentExplorationFlowPM extends Equatable implements FlowPM {
  const AdditionalCardContentExplorationFlowPM({
    required this.vloc,
  });

  final AdditionalCardContentVloc vloc;

  @override
  List<Object?> get props {
    return [
      vloc,
    ];
  }

  AdditionalCardContentExplorationFlowPM copyWith({
    AdditionalCardContentVloc Function()? vloc,
  }) {
    return AdditionalCardContentExplorationFlowPM(
      vloc: vloc == null ? this.vloc : vloc(),
    );
  }
}
