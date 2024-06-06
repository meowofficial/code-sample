part of 'use_case.dart';

class UsageExamplesOuterUpdateHandlingResult extends Equatable {
  const UsageExamplesOuterUpdateHandlingResult({
    required this.usageExamples,
  });

  final BuiltList<LexicalItemUsageExample> usageExamples;

  @override
  List<Object?> get props {
    return [
      usageExamples,
    ];
  }
}
