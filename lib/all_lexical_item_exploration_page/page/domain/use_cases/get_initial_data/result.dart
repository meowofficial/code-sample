part of 'use_case.dart';

class InitialDataGettingResult extends Equatable {
  const InitialDataGettingResult({
    required this.filteredLexicalItems,
    required this.lexicalItemProgressPercentMap,
    required this.permittedLexicalItemIds,
    required this.searchByTitle,
    required this.searchBarInputText,
  });

  final BuiltList<LexicalItem> filteredLexicalItems;
  final BuiltMap<String, int> lexicalItemProgressPercentMap;
  final BuiltSet<String> permittedLexicalItemIds;
  final bool searchByTitle;
  final String searchBarInputText;

  @override
  List<Object?> get props {
    return [
      filteredLexicalItems,
      lexicalItemProgressPercentMap,
      permittedLexicalItemIds,
      searchByTitle,
      searchBarInputText,
    ];
  }
}
