part of 'use_case.dart';

class LexicalItemOuterUpdateHandlingResult extends Equatable {
  const LexicalItemOuterUpdateHandlingResult({
    required this.lexicalItem,
    required this.imagePath,
    required this.safeToPronounce,
    required this.displayLexicalItemType,
  });

  final LexicalItem lexicalItem;
  final String? imagePath;
  final bool safeToPronounce;
  final bool displayLexicalItemType;

  @override
  List<Object?> get props {
    return [
      lexicalItem,
      imagePath,
      safeToPronounce,
      displayLexicalItemType,
    ];
  }
}
