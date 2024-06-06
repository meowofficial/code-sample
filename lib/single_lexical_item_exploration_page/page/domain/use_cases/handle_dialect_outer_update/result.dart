part of 'use_case.dart';

class DialectOuterUpdateHandlingResult extends Equatable {
  const DialectOuterUpdateHandlingResult({
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
