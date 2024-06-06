import 'package:built_collection/built_collection.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/create_deletion_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/card_action.dart';
import 'package:mobile_app.core/core/domain/helpers/create_addition_to_custom_collection_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_addition_to_learning_queue_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_editing_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_exclusion_from_learning_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_mark_as_completely_learned_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_mark_as_known_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_mistake_report_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_progress_reset_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_removal_from_learning_queue_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/create_return_to_learning_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/get_permitted_collection_list_item_ids/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/get_permitted_lexical_item_ids/helper.dart';

abstract class GetCardActions {
  BuiltList<CardAction> call({
    required LexicalItem lexicalItem,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class GetCardActionsImpl implements GetCardActions {
  const GetCardActionsImpl({
    required CreateAdditionToCustomCollectionCardActionIfReasonable
        createAdditionToCustomCollectionCardActionIfReasonable,
    required CreateAdditionToLearningQueueCardActionIfReasonable
        createAdditionToLearningQueueCardActionIfReasonable,
    required CreateDeletionCardActionIfReasonable createDeletionCardActionIfReasonable,
    required CreateEditingCardActionIfReasonable createEditingCardActionIfReasonable,
    required CreateExclusionFromLearningCardActionIfReasonable
        createExclusionFromLearningCardActionIfReasonable,
    required CreateMarkAsCompletelyLearnedCardActionIfReasonable
        createMarkAsCompletelyLearnedCardActionIfReasonable,
    required CreateMarkAsKnownCardActionIfReasonable createMarkAsKnownCardActionIfReasonable,
    required CreateMistakeReportCardActionIfReasonable createMistakeReportCardActionIfReasonable,
    required CreateProgressResetCardActionIfReasonable createProgressResetCardActionIfReasonable,
    required CreateRemovalFromLearningQueueCardActionIfReasonable
        createRemovalFromLearningQueueCardActionIfReasonable,
    required CreateReturnToLearningCardActionIfReasonable
        createReturnToLearningCardActionIfReasonable,
    required GetPermittedCollectionListItemIds getPermittedCollectionListItemIds,
    required GetPermittedLexicalItemIds getPermittedLexicalItemIds,
  })  : _createAdditionToCustomCollectionCardActionIfReasonable =
            createAdditionToCustomCollectionCardActionIfReasonable,
        _createAdditionToLearningQueueCardActionIfReasonable =
            createAdditionToLearningQueueCardActionIfReasonable,
        _createDeletionCardActionIfReasonable = createDeletionCardActionIfReasonable,
        _createEditingCardActionIfReasonable = createEditingCardActionIfReasonable,
        _createExclusionFromLearningCardActionIfReasonable =
            createExclusionFromLearningCardActionIfReasonable,
        _createMarkAsCompletelyLearnedCardActionIfReasonable =
            createMarkAsCompletelyLearnedCardActionIfReasonable,
        _createMarkAsKnownCardActionIfReasonable = createMarkAsKnownCardActionIfReasonable,
        _createMistakeReportCardActionIfReasonable = createMistakeReportCardActionIfReasonable,
        _createProgressResetCardActionIfReasonable = createProgressResetCardActionIfReasonable,
        _createRemovalFromLearningQueueCardActionIfReasonable =
            createRemovalFromLearningQueueCardActionIfReasonable,
        _createReturnToLearningCardActionIfReasonable =
            createReturnToLearningCardActionIfReasonable,
        _getPermittedCollectionListItemIds = getPermittedCollectionListItemIds,
        _getPermittedLexicalItemIds = getPermittedLexicalItemIds;

  final CreateAdditionToCustomCollectionCardActionIfReasonable
      _createAdditionToCustomCollectionCardActionIfReasonable;
  final CreateAdditionToLearningQueueCardActionIfReasonable
      _createAdditionToLearningQueueCardActionIfReasonable;
  final CreateDeletionCardActionIfReasonable _createDeletionCardActionIfReasonable;
  final CreateEditingCardActionIfReasonable _createEditingCardActionIfReasonable;
  final CreateExclusionFromLearningCardActionIfReasonable
      _createExclusionFromLearningCardActionIfReasonable;
  final CreateMarkAsCompletelyLearnedCardActionIfReasonable
      _createMarkAsCompletelyLearnedCardActionIfReasonable;
  final CreateMarkAsKnownCardActionIfReasonable _createMarkAsKnownCardActionIfReasonable;
  final CreateMistakeReportCardActionIfReasonable _createMistakeReportCardActionIfReasonable;
  final CreateProgressResetCardActionIfReasonable _createProgressResetCardActionIfReasonable;
  final CreateRemovalFromLearningQueueCardActionIfReasonable
      _createRemovalFromLearningQueueCardActionIfReasonable;
  final CreateReturnToLearningCardActionIfReasonable _createReturnToLearningCardActionIfReasonable;
  final GetPermittedCollectionListItemIds _getPermittedCollectionListItemIds;
  final GetPermittedLexicalItemIds _getPermittedLexicalItemIds;

  @override
  BuiltList<CardAction> call({
    required LexicalItem lexicalItem,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final cardActions = <CardAction>[];

    final permittedCollectionListItemIds = _getPermittedCollectionListItemIds(
      collectionListItems: collectionListItems,
      premiumAccessStatus: premiumAccessStatus,
    );

    final permittedLexicalItemIds = _getPermittedLexicalItemIds(
      collectionListItems: collectionListItems,
      permittedCollectionListItemIds: permittedCollectionListItemIds,
      lexicalItemMap: lexicalItemMap,
      premiumAccessStatus: premiumAccessStatus,
    );

    final lexicalItemPermitted = permittedLexicalItemIds.contains(lexicalItem.id);

    final mistakeReportCardAction = _createMistakeReportCardActionIfReasonable(
      lexicalItem: lexicalItem,
      availableEmailApps: availableEmailApps,
    );

    if (mistakeReportCardAction != null) {
      cardActions.add(mistakeReportCardAction);
    }

    final progressResetCardAction = _createProgressResetCardActionIfReasonable(
      lexicalItem: lexicalItem,
    );

    if (progressResetCardAction != null) {
      cardActions.add(progressResetCardAction);
    }

    final markAsKnownCardAction = _createMarkAsKnownCardActionIfReasonable(
      lexicalItem: lexicalItem,
      lexicalItemPermitted: lexicalItemPermitted,
    );

    if (markAsKnownCardAction != null) {
      cardActions.add(markAsKnownCardAction);
    }

    final markAsCompletelyLearnedCardAction = _createMarkAsCompletelyLearnedCardActionIfReasonable(
      lexicalItem: lexicalItem,
      lexicalItemPermitted: lexicalItemPermitted,
      premiumAccessStatus: premiumAccessStatus,
    );

    if (markAsCompletelyLearnedCardAction != null) {
      cardActions.add(markAsCompletelyLearnedCardAction);
    }

    final additionToLearningQueueCardAction = _createAdditionToLearningQueueCardActionIfReasonable(
      lexicalItem: lexicalItem,
      lexicalItemPermitted: lexicalItemPermitted,
      premiumAccessStatus: premiumAccessStatus,
    );

    if (additionToLearningQueueCardAction != null) {
      cardActions.add(additionToLearningQueueCardAction);
    }

    final removalFromLearningQueueCardAction =
        _createRemovalFromLearningQueueCardActionIfReasonable(
      lexicalItem: lexicalItem,
    );

    if (removalFromLearningQueueCardAction != null) {
      cardActions.add(removalFromLearningQueueCardAction);
    }

    final returnToLearningCardAction = _createReturnToLearningCardActionIfReasonable(
      lexicalItem: lexicalItem,
    );

    if (returnToLearningCardAction != null) {
      cardActions.add(returnToLearningCardAction);
    }

    final additionToCollectionCardAction = _createAdditionToCustomCollectionCardActionIfReasonable(
      lexicalItem: lexicalItem,
      lexicalItemPermitted: lexicalItemPermitted,
      collectionListItems: collectionListItems,
      permittedCollectionListItemIds: permittedCollectionListItemIds,
    );

    if (additionToCollectionCardAction != null) {
      cardActions.add(additionToCollectionCardAction);
    }

    final exclusionFromLearningCardAction = _createExclusionFromLearningCardActionIfReasonable(
      lexicalItem: lexicalItem,
      lexicalItemPermitted: lexicalItemPermitted,
      premiumAccessStatus: premiumAccessStatus,
    );

    if (exclusionFromLearningCardAction != null) {
      cardActions.add(exclusionFromLearningCardAction);
    }

    final editingCardAction = _createEditingCardActionIfReasonable(
      lexicalItem: lexicalItem,
    );

    if (editingCardAction != null) {
      cardActions.add(editingCardAction);
    }

    final deletionCardAction = _createDeletionCardActionIfReasonable(
      lexicalItem: lexicalItem,
    );

    if (deletionCardAction != null) {
      cardActions.add(deletionCardAction);
    }

    return cardActions.build();
  }
}
