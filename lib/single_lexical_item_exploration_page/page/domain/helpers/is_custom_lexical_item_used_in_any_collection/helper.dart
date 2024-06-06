import 'package:built_collection/built_collection.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';

abstract class IsCustomLexicalItemUsedInAnyCollection {
  bool call({
    required String lexicalItemId,
    required BuiltList<CollectionListItem> collectionListItems,
  });
}

class IsCustomLexicalItemUsedInAnyCollectionImpl implements IsCustomLexicalItemUsedInAnyCollection {
  const IsCustomLexicalItemUsedInAnyCollectionImpl();

  @override
  bool call({
    required String lexicalItemId,
    required BuiltList<CollectionListItem> collectionListItems,
  }) {
    for (final collectionListItem in collectionListItems) {
      switch (collectionListItem) {
        case CustomCollection():
          final collection = collectionListItem;

          if (collection.lexicalItemIds.contains(lexicalItemId)) {
            return true;
          }

        case CustomCollectionFolder():
          final collectionFolder = collectionListItem;

          for (final collection in collectionFolder.collections) {
            if (collection.lexicalItemIds.contains(lexicalItemId)) {
              return true;
            }
          }

        case InbuiltCollectionListItem():
          break;
      }
    }

    return false;
  }
}
