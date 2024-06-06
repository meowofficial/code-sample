part of 'use_case.dart';

sealed class LexicalItemAdditionToCustomCollectionResult {}

class ActionNotPermittedLexicalItemAdditionToCustomCollectionResult extends Equatable
    implements LexicalItemAdditionToCustomCollectionResult {
  const ActionNotPermittedLexicalItemAdditionToCustomCollectionResult({
    required this.notification,
  });

  final PurchasePageOpeningNotification notification;

  @override
  List<Object?> get props {
    return [
      notification,
    ];
  }
}

class CollectionSelectionRequiredLexicalItemAdditionToCustomCollectionResult extends Equatable
    implements LexicalItemAdditionToCustomCollectionResult {
  const CollectionSelectionRequiredLexicalItemAdditionToCustomCollectionResult({
    required this.notification,
  });

  final AdditionToCollectionDialogOpeningNotification notification;

  @override
  List<Object?> get props {
    return [
      notification,
    ];
  }
}

class SucceededLexicalItemAdditionToCustomCollectionResult extends Equatable
    implements LexicalItemAdditionToCustomCollectionResult {
  const SucceededLexicalItemAdditionToCustomCollectionResult({
    required this.currentFlowM,
    required this.collectionListItems,
    required this.shouldShowSuccessIndicator,
  });

  final FlowM currentFlowM;
  final BuiltList<CollectionListItem> collectionListItems;
  final bool shouldShowSuccessIndicator;

  @override
  List<Object?> get props {
    return [
      currentFlowM,
      collectionListItems,
      shouldShowSuccessIndicator,
    ];
  }
}
