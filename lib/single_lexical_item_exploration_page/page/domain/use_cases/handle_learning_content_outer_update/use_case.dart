import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/services/image_service/service.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/is_additional_content_present/helper.dart';

part 'results.dart';

abstract class HandleLearningContentOuterUpdate {
  LearningContentOuterUpdateHandlingResult? call({
    required String lexicalItemId,
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required BuiltList<EmailApp> availableEmailApps,
    required bool imageEnablementEffective,
    required Dialect dialect,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required bool lexicalItemDeleted,
  });
}

class HandleLearningContentOuterUpdateImpl implements HandleLearningContentOuterUpdate {
  const HandleLearningContentOuterUpdateImpl({
    required GetCardActions getCardActions,
    required IsAdditionalContentPresent isAdditionalContentPresent,
    required ImageService imageService,
  })  : _getCardActions = getCardActions,
        _isAdditionalContentPresent = isAdditionalContentPresent,
        _imageService = imageService;

  final GetCardActions _getCardActions;
  final IsAdditionalContentPresent _isAdditionalContentPresent;

  final ImageService _imageService;

  @override
  LearningContentOuterUpdateHandlingResult? call({
    required String lexicalItemId,
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required BuiltList<EmailApp> availableEmailApps,
    required bool imageEnablementEffective,
    required Dialect dialect,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required bool lexicalItemDeleted,
  }) {
    if (lexicalItemDeleted) {
      return null;
    }

    final lexicalItem = lexicalItemMap[lexicalItemId];

    if (lexicalItem == null) {
      final result = NonexistentLexicalItemLearningContentOuterUpdateHandlingResult(
        lexicalItemDeleted: true,
        lexicalItemMap: lexicalItemMap,
      );

      return result;
    }

    final updatedAdditionalContentPresent = _isAdditionalContentPresent(
      lexicalItem: lexicalItem,
    );

    if (!updatedAdditionalContentPresent) {
      if (currentFlowM is AdditionalCardContentExplorationFlowM && nextFlowM == null ||
          currentFlowM is MainCardContentExplorationFlowM &&
              nextFlowM is AdditionalCardContentExplorationFlowM) {
        final cardActions = _getCardActions(
          lexicalItem: lexicalItem,
          lexicalItemMap: lexicalItemMap,
          collectionListItems: collectionListItems,
          premiumAccessStatus: premiumAccessStatus,
          availableEmailApps: availableEmailApps,
        );

        final updatedCurrentFlowM = MainCardContentExplorationFlowM(
          lexicalItem: lexicalItem,
          dialect: dialect,
          additionalContentPresent: updatedAdditionalContentPresent,
          imageEnablementEffective: imageEnablementEffective,
          cachedImagePathMap: _imageService.cachedImagePathMap,
          unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
          cardActions: cardActions,
        );

        final result = SucceededLearningContentOuterUpdateHandlingResult(
          currentFlowM: updatedCurrentFlowM,
          nextFlowM: null,
          lexicalItemMap: lexicalItemMap,
        );

        return result;
      }
    }

    switch (nextFlowM) {
      case null:
        switch (currentFlowM) {
          case AdditionalCardContentExplorationFlowM():
            final updatedCurrentFlowM = currentFlowM.copyWith(
              usageExamples: () => lexicalItem.usageExamples,
            );

            final result = SucceededLearningContentOuterUpdateHandlingResult(
              currentFlowM: updatedCurrentFlowM,
              nextFlowM: nextFlowM,
              lexicalItemMap: lexicalItemMap,
            );

            return result;

          case MainCardContentExplorationFlowM():
            final updatedCardActions = _getCardActions(
              lexicalItem: lexicalItem,
              lexicalItemMap: lexicalItemMap,
              collectionListItems: collectionListItems,
              premiumAccessStatus: premiumAccessStatus,
              availableEmailApps: availableEmailApps,
            );

            final updatedCurrentFlowM = currentFlowM.copyWith(
              lexicalItem: () => lexicalItem,
              cardActions: () => updatedCardActions,
              additionalContentPresent: () => updatedAdditionalContentPresent,
            );

            final result = SucceededLearningContentOuterUpdateHandlingResult(
              currentFlowM: updatedCurrentFlowM,
              nextFlowM: nextFlowM,
              lexicalItemMap: lexicalItemMap,
            );

            return result;
        }

      case AdditionalCardContentExplorationFlowM():
        final updatedNextFlowM = nextFlowM.copyWith(
          usageExamples: () => lexicalItem.usageExamples,
        );

        final result = SucceededLearningContentOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: updatedNextFlowM,
          lexicalItemMap: lexicalItemMap,
        );

        return result;

      case MainCardContentExplorationFlowM():
        final updatedCardActions = _getCardActions(
          lexicalItem: lexicalItem,
          lexicalItemMap: lexicalItemMap,
          collectionListItems: collectionListItems,
          premiumAccessStatus: premiumAccessStatus,
          availableEmailApps: availableEmailApps,
        );

        final updatedNextFlowM = nextFlowM.copyWith(
          lexicalItem: () => lexicalItem,
          cardActions: () => updatedCardActions,
          additionalContentPresent: () => updatedAdditionalContentPresent,
        );

        final result = SucceededLearningContentOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: updatedNextFlowM,
          lexicalItemMap: lexicalItemMap,
        );

        return result;
    }
  }
}
