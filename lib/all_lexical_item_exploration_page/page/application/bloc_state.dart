part of 'bloc.dart';

class AllLexicalItemExplorationPageBlocState extends Equatable {
  const AllLexicalItemExplorationPageBlocState({
    required this.filteredLexicalItems,
    required this.lexicalItemProgressPercentMap,
    required this.permittedLexicalItemIds,
    required this.searchBarInputText,
    required this.searchByTitle,
  });

  final BuiltList<LexicalItem> filteredLexicalItems;
  final BuiltMap<String, int> lexicalItemProgressPercentMap;
  final BuiltSet<String> permittedLexicalItemIds;
  final String searchBarInputText;
  final bool searchByTitle;

  @override
  List<Object?> get props {
    return [
      filteredLexicalItems,
      lexicalItemProgressPercentMap,
      permittedLexicalItemIds,
      searchBarInputText,
      searchByTitle,
    ];
  }

  AllLexicalItemExplorationPageBlocState copyWith({
    BuiltList<LexicalItem> Function()? filteredLexicalItems,
    BuiltMap<String, int> Function()? lexicalItemProgressPercentMap,
    BuiltSet<String> Function()? permittedLexicalItemIds,
    String Function()? searchBarInputText,
    bool Function()? searchByTitle,
  }) {
    return AllLexicalItemExplorationPageBlocState(
      filteredLexicalItems:
          filteredLexicalItems == null ? this.filteredLexicalItems : filteredLexicalItems(),
      lexicalItemProgressPercentMap: lexicalItemProgressPercentMap == null
          ? this.lexicalItemProgressPercentMap
          : lexicalItemProgressPercentMap(),
      permittedLexicalItemIds: permittedLexicalItemIds == null
          ? this.permittedLexicalItemIds
          : permittedLexicalItemIds(),
      searchBarInputText: searchBarInputText == null ? this.searchBarInputText : searchBarInputText(),
      searchByTitle: searchByTitle == null ? this.searchByTitle : searchByTitle(),
    );
  }
}
