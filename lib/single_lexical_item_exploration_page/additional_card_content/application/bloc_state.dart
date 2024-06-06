part of 'bloc.dart';

class AdditionalCardContentBlocState {
  const AdditionalCardContentBlocState({
    required this.usageExamples,
    required this.flowCompleted,
  });

  final BuiltList<LexicalItemUsageExample> usageExamples;
  final bool flowCompleted;

  AdditionalCardContentBlocState copyWith({
    BuiltList<LexicalItemUsageExample> Function()? usageExamples,
    bool Function()? flowCompleted,
  }) {
    return AdditionalCardContentBlocState(
      usageExamples: usageExamples == null ? this.usageExamples : usageExamples(),
      flowCompleted: flowCompleted == null ? this.flowCompleted : flowCompleted(),
    );
  }
}
