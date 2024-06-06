import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_return_to_learning/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_update/helper.dart';
import 'package:mobile_app.core/core/domain/repositories/learning_content_repository/repository.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';

part 'result.dart';

abstract class ReturnLexicalItemToLearning {
  LexicalItemReturnToLearningResult call({
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class ReturnLexicalItemToLearningImpl implements ReturnLexicalItemToLearning {
  const ReturnLexicalItemToLearningImpl({
    required ApplyLexicalItemReturnToLearning applyLexicalItemReturnToLearning,
    required ApplyLexicalItemUpdate applyLexicalItemUpdate,
    required GetCardActions getCardActions,
    required LearningContentRepository learningContentRepository,
  })  : _applyLexicalItemReturnToLearning = applyLexicalItemReturnToLearning,
        _applyLexicalItemUpdate = applyLexicalItemUpdate,
        _getCardActions = getCardActions,
        _learningContentRepository = learningContentRepository;

  final ApplyLexicalItemReturnToLearning _applyLexicalItemReturnToLearning;
  final ApplyLexicalItemUpdate _applyLexicalItemUpdate;
  final GetCardActions _getCardActions;

  final LearningContentRepository _learningContentRepository;

  @override
  LexicalItemReturnToLearningResult call({
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final updatedLexicalItem = _applyLexicalItemReturnToLearning(
      lexicalItem: currentFlowM.lexicalItem,
    );

    final updatedLexicalItemMap = _applyLexicalItemUpdate(
      updatedLexicalItem: updatedLexicalItem,
      lexicalItemMap: lexicalItemMap,
    );

    unawaited(_learningContentRepository.saveLexicalItems(
      lexicalItems: updatedLexicalItemMap.values.toBuiltList(),
    ));

    final updatedCardActions = _getCardActions(
      lexicalItem: updatedLexicalItem,
      lexicalItemMap: updatedLexicalItemMap,
      collectionListItems: collectionListItems,
      premiumAccessStatus: premiumAccessStatus,
      availableEmailApps: availableEmailApps,
    );

    final updatedCurrentFlowM = currentFlowM.copyWith(
      lexicalItem: () => updatedLexicalItem,
      cardActions: () => updatedCardActions,
    );

    final result = LexicalItemReturnToLearningResult(
      currentFlowM: updatedCurrentFlowM,
      lexicalItemMap: updatedLexicalItemMap,
      shouldShowSuccessIndicator: true,
    );

    return result;
  }
}
