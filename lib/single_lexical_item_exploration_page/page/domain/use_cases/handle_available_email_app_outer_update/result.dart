part of 'use_case.dart';

class AvailableEmailAppOuterUpdateHandlingResult extends Equatable {
  const AvailableEmailAppOuterUpdateHandlingResult({
    required this.currentFlowM,
    required this.nextFlowM,
  });

  final FlowM currentFlowM;
  final FlowM? nextFlowM;

  @override
  List<Object?> get props {
    return [
      currentFlowM,
      nextFlowM,
    ];
  }
}
