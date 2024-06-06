part of 'flow_m.dart';

class AdditionalCardContentExplorationFlowM extends Equatable implements FlowM {
  const AdditionalCardContentExplorationFlowM({
    required this.usageExamples,
  });

  final BuiltList<LexicalItemUsageExample> usageExamples;

  @override
  List<Object?> get props {
    return [
      usageExamples,
    ];
  }

  AdditionalCardContentExplorationFlowM copyWith({
    BuiltList<LexicalItemUsageExample> Function()? usageExamples,
  }) {
    return AdditionalCardContentExplorationFlowM(
      usageExamples: usageExamples == null ? this.usageExamples : usageExamples(),
    );
  }
}
