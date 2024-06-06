part of 'flow_pm.dart';

class MainCardContentExplorationFlowPM extends Equatable implements FlowPM {
  const MainCardContentExplorationFlowPM({
    required this.vloc,
  });

  final MainCardContentVloc vloc;

  @override
  List<Object?> get props {
    return [
      vloc,
    ];
  }

  MainCardContentExplorationFlowPM copyWith({
    MainCardContentVloc Function()? vloc,
  }) {
    return MainCardContentExplorationFlowPM(
      vloc: vloc == null ? this.vloc : vloc(),
    );
  }
}
