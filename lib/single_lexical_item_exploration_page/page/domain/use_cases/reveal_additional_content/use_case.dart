import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/card_additional_content_revealing_method.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_tms/flow_tm.dart';

part 'result.dart';

abstract class RevealAdditionalContent {
  AdditionalContentRevealingResult call({
    required CardAdditionalContentRevealingMethod method,
    required String lexicalItemId,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
  });
}

class RevealAdditionalContentImpl implements RevealAdditionalContent {
  const RevealAdditionalContentImpl();

  @override
  AdditionalContentRevealingResult call({
    required CardAdditionalContentRevealingMethod method,
    required String lexicalItemId,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
  }) {
    final lexicalItem = lexicalItemMap[lexicalItemId]!;

    final nextFlowM = AdditionalCardContentExplorationFlowM(
      usageExamples: lexicalItem.usageExamples,
    );

    final flowTM = MainToAdditionalCardContentExplorationFlowTM(
      method: method,
    );

    final result = AdditionalContentRevealingResult(
      nextFlowM: nextFlowM,
      flowTM: flowTM,
    );

    return result;
  }
}
