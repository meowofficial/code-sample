import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/addition_to_collection_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/payment_mechanism.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_collection_list_item_update/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_addition_to_custom_collection/helper.dart';
import 'package:mobile_app.core/core/domain/repositories/learning_content_repository/repository.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';

part 'results.dart';

abstract class AddLexicalItemToCustomCollection {
  LexicalItemAdditionToCustomCollectionResult call({
    required String? selectedCustomCollectionId,
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required PaymentMechanism paymentMechanism,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class AddLexicalItemToCustomCollectionImpl implements AddLexicalItemToCustomCollection {
  const AddLexicalItemToCustomCollectionImpl({
    required ApplyCollectionListItemUpdate applyCollectionListItemUpdate,
    required ApplyLexicalItemAdditionToCustomCollection applyLexicalItemAdditionToCustomCollection,
    required GetCardActions getCardActions,
    required LearningContentRepository learningContentRepository,
  })  : _applyCollectionListItemUpdate = applyCollectionListItemUpdate,
        _applyLexicalItemAdditionToCustomCollection = applyLexicalItemAdditionToCustomCollection,
        _getCardActions = getCardActions,
        _learningContentRepository = learningContentRepository;

  final ApplyCollectionListItemUpdate _applyCollectionListItemUpdate;
  final ApplyLexicalItemAdditionToCustomCollection _applyLexicalItemAdditionToCustomCollection;
  final GetCardActions _getCardActions;

  final LearningContentRepository _learningContentRepository;

  @override
  LexicalItemAdditionToCustomCollectionResult call({
    required String? selectedCustomCollectionId,
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required PaymentMechanism paymentMechanism,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final cardAction = currentFlowM.cardActions.firstWhere((cardAction) {
      return cardAction is AdditionToCustomCollectionCardAction;
    }) as AdditionToCustomCollectionCardAction;

    if (!cardAction.permitted) {
      final notification = PurchasePageOpeningNotification(
        paymentMechanism: paymentMechanism,
      );

      final result = ActionNotPermittedLexicalItemAdditionToCustomCollectionResult(
        notification: notification,
      );

      return result;
    }

    final String customCollectionId;

    if (selectedCustomCollectionId == null) {
      if (cardAction.collectionInfos.length == 1) {
        customCollectionId = cardAction.collectionInfos.first.customCollection.id;
      } else {
        final notification = AdditionToCollectionDialogOpeningNotification(
          collectionInfos: cardAction.collectionInfos,
        );

        final result = CollectionSelectionRequiredLexicalItemAdditionToCustomCollectionResult(
          notification: notification,
        );

        return result;
      }
    } else {
      customCollectionId = selectedCustomCollectionId;
    }

    final updatedCustomCollection = _applyLexicalItemAdditionToCustomCollection(
      lexicalItemId: currentFlowM.lexicalItem.id,
      customCollectionId: customCollectionId,
      collectionListItems: collectionListItems,
    );

    final updatedCollectionListItems = _applyCollectionListItemUpdate(
      updatedCollectionListItem: updatedCustomCollection,
      collectionListItems: collectionListItems,
    );

    unawaited(_learningContentRepository.saveCollectionListItems(
      collectionListItems: updatedCollectionListItems,
    ));

    final updatedCardActions = _getCardActions(
      lexicalItem: currentFlowM.lexicalItem,
      lexicalItemMap: lexicalItemMap,
      collectionListItems: updatedCollectionListItems,
      premiumAccessStatus: premiumAccessStatus,
      availableEmailApps: availableEmailApps,
    );

    final updatedCurrentFlowM = currentFlowM.copyWith(
      cardActions: () => updatedCardActions,
    );

    final result = SucceededLexicalItemAdditionToCustomCollectionResult(
      currentFlowM: updatedCurrentFlowM,
      collectionListItems: updatedCollectionListItems,
      shouldShowSuccessIndicator: true,
    );

    return result;
  }
}
