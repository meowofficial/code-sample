import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';

part 'result.dart';

abstract interface class GetInitialData {
  InitialDataGettingResult call({
    required BuiltList<LexicalItemUsageExample> usageExamples,
  });
}

class GetInitialDataImpl implements GetInitialData {
  const GetInitialDataImpl();

  @override
  InitialDataGettingResult call({
    required BuiltList<LexicalItemUsageExample> usageExamples,
  }) {
    final result = InitialDataGettingResult(
      usageExamples: usageExamples,
      flowCompleted: false,
    );

    return result;
  }
}
