part of 'use_case.dart';

class SearchBarInputTextChangeResult extends Equatable {
  const SearchBarInputTextChangeResult({
    required this.filteredLexicalItems,
    required this.searchByTitle,
    required this.searchBarInputText,
  });

  final BuiltList<LexicalItem> filteredLexicalItems;
  final bool searchByTitle;
  final String searchBarInputText;

  @override
  List<Object?> get props {
    return [
      filteredLexicalItems,
      searchByTitle,
      searchBarInputText,
    ];
  }
}
