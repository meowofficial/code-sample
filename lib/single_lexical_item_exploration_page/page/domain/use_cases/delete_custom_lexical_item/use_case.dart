import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/app_navigator_transition_info.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/page_models/app_navigator_page_model.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_all_collection_list_item_nonexistent_lexical_item_removal/helper.dart';
import 'package:mobile_app.core/core/domain/repositories/learning_content_repository/repository.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/is_custom_lexical_item_used_in_any_collection/helper.dart';

part 'results.dart';

abstract interface class DeleteCustomLexicalItem {
  CustomLexicalItemDeletionResult call({
    required SingleLexicalItemExplorationPageModel pageModel,
    required String lexicalItemId,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required BuiltMap<AppNavigatorPageModel, AppNavigatorTransitionInfo>
        collectionNavigatorPageModelToTransitionInfo,
    bool? lexicalItemDeletionConfirmed,
  });
}

class DeleteCustomLexicalItemImpl implements DeleteCustomLexicalItem {
  const DeleteCustomLexicalItemImpl({
    required ApplyAllCollectionListItemNonexistentLexicalItemRemoval
        applyAllCollectionListItemNonexistentLexicalItemRemoval,
    required IsCustomLexicalItemUsedInAnyCollection isCustomLexicalItemUsedInAnyCollection,
    required LearningContentRepository learningContentRepository,
  })  : _applyAllCollectionListItemNonexistentLexicalItemRemoval =
            applyAllCollectionListItemNonexistentLexicalItemRemoval,
        _isCustomLexicalItemUsedInAnyCollection = isCustomLexicalItemUsedInAnyCollection,
        _learningContentRepository = learningContentRepository;

  final ApplyAllCollectionListItemNonexistentLexicalItemRemoval
      _applyAllCollectionListItemNonexistentLexicalItemRemoval;
  final IsCustomLexicalItemUsedInAnyCollection _isCustomLexicalItemUsedInAnyCollection;

  final LearningContentRepository _learningContentRepository;

  @override
  CustomLexicalItemDeletionResult call({
    required SingleLexicalItemExplorationPageModel pageModel,
    required String lexicalItemId,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required BuiltMap<AppNavigatorPageModel, AppNavigatorTransitionInfo>
        collectionNavigatorPageModelToTransitionInfo,
    bool? lexicalItemDeletionConfirmed,
  }) {
    if (lexicalItemDeletionConfirmed != true) {
      final lexicalItemUsedInAnyCollection = _isCustomLexicalItemUsedInAnyCollection(
        lexicalItemId: lexicalItemId,
        collectionListItems: collectionListItems,
      );

      if (lexicalItemUsedInAnyCollection) {
        const notification = UsedCustomLexicalItemDeletionConfirmationDialogOpeningNotification();

        const result = DeletionConfirmationRequiredCustomLexicalItemDeletionResult(
          notification: notification,
        );

        return result;
      }

      const notification = OrphanCustomLexicalItemDeletionConfirmationDialogOpeningNotification();

      const result = DeletionConfirmationRequiredCustomLexicalItemDeletionResult(
        notification: notification,
      );

      return result;
    }

    final updatedLexicalItemMap = lexicalItemMap.rebuild((lexicalItemMap) {
      lexicalItemMap.remove(lexicalItemId);
    });

    final updatedCollectionListItems = _applyAllCollectionListItemNonexistentLexicalItemRemoval(
      lexicalItemMap: updatedLexicalItemMap,
      collectionListItems: collectionListItems,
    );

    unawaited(Future.wait([
      _learningContentRepository.saveLexicalItems(
        lexicalItems: updatedLexicalItemMap.values.toBuiltList(),
      ),
      _learningContentRepository.saveCollectionListItems(
        collectionListItems: updatedCollectionListItems,
      ),
    ]));

    const removalTransitionInfo = RemovalNavigatorTransitionInfo(
      displayTransition: true,
    );

    final updatedCollectionNavigatorPageModelToTransitionInfo =
        collectionNavigatorPageModelToTransitionInfo
            .rebuild((collectionNavigatorPageModelToTransitionInfo) {
      collectionNavigatorPageModelToTransitionInfo[pageModel] = removalTransitionInfo;
    });

    final result = SucceededCustomLexicalItemDeletionResult(
      lexicalItemMap: updatedLexicalItemMap,
      collectionListItems: updatedCollectionListItems,
      collectionNavigatorPageModelToTransitionInfo:
          updatedCollectionNavigatorPageModelToTransitionInfo,
      shouldShowSuccessIndicator: true,
      lexicalItemDeleted: true,
    );

    return result;
  }
}
