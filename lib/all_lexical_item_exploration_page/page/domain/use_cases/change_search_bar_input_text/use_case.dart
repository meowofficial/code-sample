import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/helpers/sort_lexical_items/helper.dart';
import 'package:mobile_app.home.collections.core/core/domain/helpers/filter_lexical_items_by_prefix/helper.dart';
import 'package:mobile_app.home.collections.core/core/domain/helpers/is_lexical_item_title_prefix/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/helpers/get_filtered_lexical_item_sorting/helper.dart';

part 'result.dart';

abstract class ChangeSearchBarInputText {
  SearchBarInputTextChangeResult call({
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required String searchBarInputText,
  });
}

class ChangeSearchBarInputTextImpl implements ChangeSearchBarInputText {
  const ChangeSearchBarInputTextImpl({
    required FilterLexicalItemsByPrefix filterLexicalItemsByPrefix,
    required GetFilteredLexicalItemSorting getFilteredLexicalItemSorting,
    required IsLexicalItemTitlePrefix isLexicalItemTitlePrefix,
    required SortLexicalItems sortLexicalItems,
  })  : _filterLexicalItemsByPrefix = filterLexicalItemsByPrefix,
        _getFilteredLexicalItemSorting = getFilteredLexicalItemSorting,
        _isLexicalItemTitlePrefix = isLexicalItemTitlePrefix,
        _sortLexicalItems = sortLexicalItems;

  final FilterLexicalItemsByPrefix _filterLexicalItemsByPrefix;
  final GetFilteredLexicalItemSorting _getFilteredLexicalItemSorting;
  final IsLexicalItemTitlePrefix _isLexicalItemTitlePrefix;
  final SortLexicalItems _sortLexicalItems;

  @override
  SearchBarInputTextChangeResult call({
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required String searchBarInputText,
  }) {
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

    final result = SearchBarInputTextChangeResult(
      filteredLexicalItems: filteredLexicalItems,
      searchByTitle: searchByTitle,
      searchBarInputText: searchBarInputText,
    );

    return result;
  }
}
