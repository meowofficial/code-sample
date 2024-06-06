part of 'use_case.dart';

class InitialDataGettingResult extends Equatable {
  const InitialDataGettingResult({
    required this.lexicalItem,
    required this.dialect,
    required this.imageEnablementEffective,
    required this.cachedImagePathMap,
    required this.unsafeToPronounceLexicalItemTitleMap,
    required this.imagePath,
    required this.safeToPronounce,
    required this.displayLexicalItemType,
    required this.additionalContentPresent,
    required this.flowCompleted,
  });

  final LexicalItem lexicalItem;
  final Dialect dialect;
  final bool imageEnablementEffective;
  final BuiltMap<String, String> cachedImagePathMap;
  final BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap;
  final String? imagePath;
  final bool safeToPronounce;
  final bool displayLexicalItemType;
  final bool additionalContentPresent;
  final bool flowCompleted;

  @override
  List<Object?> get props {
    return [
      lexicalItem,
      dialect,
      imageEnablementEffective,
      cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap,
      imagePath,
      safeToPronounce,
      displayLexicalItemType,
      additionalContentPresent,
      flowCompleted,
    ];
  }
}
