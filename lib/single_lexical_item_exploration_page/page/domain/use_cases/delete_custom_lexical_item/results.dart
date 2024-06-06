part of 'use_case.dart';

sealed class CustomLexicalItemDeletionResult {}

class DeletionConfirmationRequiredCustomLexicalItemDeletionResult extends Equatable
    implements CustomLexicalItemDeletionResult {
  const DeletionConfirmationRequiredCustomLexicalItemDeletionResult({
    required this.notification,
  });

  final SingleLexicalItemPageNotification notification;

  @override
  List<Object?> get props {
    return [
      notification,
    ];
  }
}

class SucceededCustomLexicalItemDeletionResult extends Equatable
    implements CustomLexicalItemDeletionResult {
  const SucceededCustomLexicalItemDeletionResult({
    required this.lexicalItemMap,
    required this.collectionListItems,
    required this.collectionNavigatorPageModelToTransitionInfo,
    required this.lexicalItemDeleted,
    required this.shouldShowSuccessIndicator,
  });

  final BuiltMap<String, LexicalItem> lexicalItemMap;
  final BuiltList<CollectionListItem> collectionListItems;
  final BuiltMap<AppNavigatorPageModel, AppNavigatorTransitionInfo>
      collectionNavigatorPageModelToTransitionInfo;
  final bool lexicalItemDeleted;
  final bool shouldShowSuccessIndicator;

  @override
  List<Object?> get props {
    return [
      lexicalItemMap,
      collectionListItems,
      collectionNavigatorPageModelToTransitionInfo,
      lexicalItemDeleted,
      shouldShowSuccessIndicator,
    ];
  }
}
