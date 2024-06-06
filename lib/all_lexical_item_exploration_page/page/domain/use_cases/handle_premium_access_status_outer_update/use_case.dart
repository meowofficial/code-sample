import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/get_permitted_collection_list_item_ids/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/get_permitted_lexical_item_ids/helper.dart';

part 'result.dart';

abstract class HandlePremiumAccessStatusOuterUpdate {
  PremiumAccessStatusOuterUpdateHandlingResult call({
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
  });
}

class HandlePremiumAccessStatusOuterUpdateImpl implements HandlePremiumAccessStatusOuterUpdate {
  const HandlePremiumAccessStatusOuterUpdateImpl({
    required GetPermittedLexicalItemIds getPermittedLexicalItemIds,
    required GetPermittedCollectionListItemIds getPermittedCollectionListItemIds,
  })  : _getPermittedLexicalItemIds = getPermittedLexicalItemIds,
        _getPermittedCollectionListItemIds = getPermittedCollectionListItemIds;

  final GetPermittedLexicalItemIds _getPermittedLexicalItemIds;
  final GetPermittedCollectionListItemIds _getPermittedCollectionListItemIds;

  @override
  PremiumAccessStatusOuterUpdateHandlingResult call({
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
  }) {
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

    final result = PremiumAccessStatusOuterUpdateHandlingResult(
      permittedLexicalItemIds: permittedLexicalItemIds,
    );

    return result;
  }
}
