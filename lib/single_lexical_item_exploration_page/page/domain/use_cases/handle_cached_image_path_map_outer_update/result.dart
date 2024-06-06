part of 'use_case.dart';

class CachedImagePathMapOuterUpdateHandlingResult extends Equatable {
  const CachedImagePathMapOuterUpdateHandlingResult({
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
