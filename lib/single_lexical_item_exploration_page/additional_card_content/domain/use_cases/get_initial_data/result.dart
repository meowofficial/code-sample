part of 'use_case.dart';

class InitialDataGettingResult extends Equatable {
  const InitialDataGettingResult({
    required this.usageExamples,
    required this.flowCompleted,
  });

  final BuiltList<LexicalItemUsageExample> usageExamples;
  final bool flowCompleted;

  @override
  List<Object?> get props {
    return [
      usageExamples,
      flowCompleted,
    ];
  }
}
