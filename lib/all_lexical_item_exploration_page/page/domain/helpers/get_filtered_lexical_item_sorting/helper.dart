import 'package:mobile_app.core/core/domain/entities/lexical_item_sorting.dart';

abstract interface class GetFilteredLexicalItemSorting {
  LexicalItemSorting call({
    required bool searchByTitle,
  });
}

class GetFilteredLexicalItemSortingImpl implements GetFilteredLexicalItemSorting {
  const GetFilteredLexicalItemSortingImpl();

  @override
  LexicalItemSorting call({
    required bool searchByTitle,
  }) {
    return searchByTitle
        ? LexicalItemSorting.titleAlphabetically
        : LexicalItemSorting.translationAlphabetically;
  }
}
