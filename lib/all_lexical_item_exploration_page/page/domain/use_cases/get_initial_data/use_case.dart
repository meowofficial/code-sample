import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/get_lexical_item_progress_percent_map/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/get_permitted_collection_list_item_ids/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/get_permitted_lexical_item_ids/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/sort_lexical_items/helper.dart';
import 'package:mobile_app.home.collections.core/core/domain/helpers/filter_lexical_items_by_prefix/helper.dart';
import 'package:mobile_app.home.collections.core/core/domain/helpers/is_lexical_item_title_prefix/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/helpers/get_filtered_lexical_item_sorting/helper.dart';

part 'result.dart';

abstract class GetInitialData {
  InitialDataGettingResult call({
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
  });
}

class GetInitialDataImpl implements GetInitialData {
  const GetInitialDataImpl({
    required FilterLexicalItemsByPrefix filterLexicalItemsByPrefix,
    required GetFilteredLexicalItemSorting getFilteredLexicalItemSorting,
    required GetLexicalItemProgressPercentMap getLexicalItemProgressPercentMap,
    required GetPermittedLexicalItemIds getPermittedLexicalItemIds,
    required GetPermittedCollectionListItemIds getPermittedCollectionListItemIds,
    required IsLexicalItemTitlePrefix isLexicalItemTitlePrefix,
    required SortLexicalItems sortLexicalItems,
  })  : _filterLexicalItemsByPrefix = filterLexicalItemsByPrefix,
        _getFilteredLexicalItemSorting = getFilteredLexicalItemSorting,
        _getLexicalItemProgressPercentMap = getLexicalItemProgressPercentMap,
        _getPermittedLexicalItemIds = getPermittedLexicalItemIds,
        _getPermittedCollectionListItemIds = getPermittedCollectionListItemIds,
        _isLexicalItemTitlePrefix = isLexicalItemTitlePrefix,
        _sortLexicalItems = sortLexicalItems;

  final FilterLexicalItemsByPrefix _filterLexicalItemsByPrefix;
  final GetFilteredLexicalItemSorting _getFilteredLexicalItemSorting;
  final GetLexicalItemProgressPercentMap _getLexicalItemProgressPercentMap;
  final GetPermittedLexicalItemIds _getPermittedLexicalItemIds;
  final GetPermittedCollectionListItemIds _getPermittedCollectionListItemIds;
  final IsLexicalItemTitlePrefix _isLexicalItemTitlePrefix;
  final SortLexicalItems _sortLexicalItems;

  @override
  InitialDataGettingResult call({
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
  }) {
    const searchBarInputText = '';

    final trimmedPrefix = searchBarInputText.trim();

    final searchByTitle = _isLexicalItemTitlePrefix(
      trimmedPrefix: trimmedPrefix,
    );

    final filteredUnsortedLexicalItems = _filterLexicalItemsByPrefix(
      lexicalItems: lexicalItemMap.values.toBuiltList(),
      searchByTitle: searchByTitle,
      prefix: trimmedPrefix,
    );

    final sorting = _getFilteredLexicalItemSorting(
      searchByTitle: searchByTitle,
    );

    final filteredLexicalItems = _sortLexicalItems(
      lexicalItems: filteredUnsortedLexicalItems,
      sorting: sorting,
    );

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

    final lexicalItemProgressPercentMap = _getLexicalItemProgressPercentMap(
      lexicalItemIds: lexicalItemMap.keys.toBuiltList(),
      lexicalItemMap: lexicalItemMap,
    );

    final result = InitialDataGettingResult(
      filteredLexicalItems: filteredLexicalItems,
      lexicalItemProgressPercentMap: lexicalItemProgressPercentMap,
      permittedLexicalItemIds: permittedLexicalItemIds,
      searchBarInputText: searchBarInputText,
      searchByTitle: searchByTitle,
    );

    return result;
  }
}
