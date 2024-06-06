import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_update/helper.dart';
import 'package:mobile_app.core/core/domain/repositories/learning_content_repository/repository.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/is_additional_content_present/helper.dart';

part 'result.dart';

abstract interface class UpdateCustomLexicalItem {
  CustomLexicalItemUpdateResult call({
    required CustomLexicalItem lexicalItem,
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class UpdateCustomLexicalItemImpl implements UpdateCustomLexicalItem {
  const UpdateCustomLexicalItemImpl({
    required ApplyLexicalItemUpdate applyLexicalItemUpdate,
    required GetCardActions getCardActions,
    required IsAdditionalContentPresent isAdditionalContentPresent,
    required LearningContentRepository learningContentRepository,
  })  : _applyLexicalItemUpdate = applyLexicalItemUpdate,
        _getCardActions = getCardActions,
        _isAdditionalContentPresent = isAdditionalContentPresent,
        _learningContentRepository = learningContentRepository;

  final ApplyLexicalItemUpdate _applyLexicalItemUpdate;
  final GetCardActions _getCardActions;
  final IsAdditionalContentPresent _isAdditionalContentPresent;

  final LearningContentRepository _learningContentRepository;

  @override
  CustomLexicalItemUpdateResult call({
    required CustomLexicalItem lexicalItem,
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final updatedLexicalItemMap = _applyLexicalItemUpdate(
      updatedLexicalItem: lexicalItem,
      lexicalItemMap: lexicalItemMap,
    );

    unawaited(_learningContentRepository.saveLexicalItems(
      lexicalItems: updatedLexicalItemMap.values.toBuiltList(),
    ));

    final updatedCardActions = _getCardActions(
      lexicalItem: lexicalItem,
      lexicalItemMap: updatedLexicalItemMap,
      collectionListItems: collectionListItems,
      premiumAccessStatus: premiumAccessStatus,
      availableEmailApps: availableEmailApps,
    );

    final updatedAdditionalContentPresent = _isAdditionalContentPresent(
      lexicalItem: lexicalItem,
    );

    final updatedCurrentFlowM = currentFlowM.copyWith(
      lexicalItem: () => lexicalItem,
      additionalContentPresent: () => updatedAdditionalContentPresent,
      cardActions: () => updatedCardActions,
    );

    final result = CustomLexicalItemUpdateResult(
      currentFlowM: updatedCurrentFlowM,
      lexicalItemMap: updatedLexicalItemMap,
      shouldShowSuccessIndicator: true,
    );

    return result;
  }
}
