part of 'use_case.dart';

class LearningContentOuterUpdateHandlingResult extends Equatable {
  const LearningContentOuterUpdateHandlingResult({
    required this.filteredLexicalItems,
    required this.lexicalItemProgressPercentMap,
    required this.permittedLexicalItemIds,
  });

  final BuiltList<LexicalItem> filteredLexicalItems;
  final BuiltMap<String, int> lexicalItemProgressPercentMap;
  final BuiltSet<String> permittedLexicalItemIds;

  @override
  List<Object?> get props {
    return [
      filteredLexicalItems,
      lexicalItemProgressPercentMap,
      permittedLexicalItemIds,
    ];
  }
}
