part of 'use_case.dart';

class PremiumAccessStatusOuterUpdateHandlingResult extends Equatable {
  const PremiumAccessStatusOuterUpdateHandlingResult({
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
