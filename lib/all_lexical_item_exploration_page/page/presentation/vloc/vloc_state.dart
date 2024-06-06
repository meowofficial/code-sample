part of 'vloc.dart';

class AllLexicalItemExplorationPageVlocState extends Equatable {
  const AllLexicalItemExplorationPageVlocState({
    required this.filteredLexicalItemPMs,
    required this.searchBarTextEditingController,
    required this.searchBarFocusNode,
  });

  final BuiltList<LexicalItemPM> filteredLexicalItemPMs;
  final TextEditingController searchBarTextEditingController;
  final FocusNode searchBarFocusNode;

  @override
  List<Object?> get props {
    return [
      filteredLexicalItemPMs,
      searchBarTextEditingController,
      searchBarFocusNode,
    ];
  }

  AllLexicalItemExplorationPageVlocState copyWith({
    BuiltList<LexicalItemPM> Function()? filteredLexicalItemPMs,
    TextEditingController Function()? searchBarTextEditingController,
    FocusNode Function()? searchBarFocusNode,
  }) {
    return AllLexicalItemExplorationPageVlocState(
      filteredLexicalItemPMs:
          filteredLexicalItemPMs == null ? this.filteredLexicalItemPMs : filteredLexicalItemPMs(),
      searchBarTextEditingController: searchBarTextEditingController == null
          ? this.searchBarTextEditingController
          : searchBarTextEditingController(),
      searchBarFocusNode:
          searchBarFocusNode == null ? this.searchBarFocusNode : searchBarFocusNode(),
    );
  }
}
