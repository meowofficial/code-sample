import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';

part 'result.dart';

abstract interface class HandleUsageExamplesOuterUpdate {
  UsageExamplesOuterUpdateHandlingResult? call({
    required BuiltList<LexicalItemUsageExample> usageExamples,
    required bool flowCompleted,
  });
}

class HandleUsageExamplesOuterUpdateImpl implements HandleUsageExamplesOuterUpdate {
  const HandleUsageExamplesOuterUpdateImpl();

  @override
  UsageExamplesOuterUpdateHandlingResult? call({
    required BuiltList<LexicalItemUsageExample> usageExamples,
    required bool flowCompleted,
  }) {
    if (flowCompleted) {
      return null;
    }

    final result = UsageExamplesOuterUpdateHandlingResult(
      usageExamples: usageExamples,
    );

    return result;
  }
}
