part of 'bloc.dart';

class MainCardContentBlocState extends Equatable {
  const MainCardContentBlocState({
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

  MainCardContentBlocState copyWith({
    LexicalItem Function()? lexicalItem,
    Dialect Function()? dialect,
    bool Function()? imageEnablementEffective,
    BuiltMap<String, String> Function()? cachedImagePathMap,
    BuiltMap<Dialect, BuiltSet<String>> Function()? unsafeToPronounceLexicalItemTitleMap,
    String? Function()? imagePath,
    bool Function()? safeToPronounce,
    bool Function()? displayLexicalItemType,
    bool Function()? additionalContentPresent,
    bool Function()? flowCompleted,
  }) {
    return MainCardContentBlocState(
      lexicalItem: lexicalItem == null ? this.lexicalItem : lexicalItem(),
      dialect: dialect == null ? this.dialect : dialect(),
      imageEnablementEffective: imageEnablementEffective == null
          ? this.imageEnablementEffective
          : imageEnablementEffective(),
      cachedImagePathMap:
          cachedImagePathMap == null ? this.cachedImagePathMap : cachedImagePathMap(),
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap == null
          ? this.unsafeToPronounceLexicalItemTitleMap
          : unsafeToPronounceLexicalItemTitleMap(),
      imagePath: imagePath == null ? this.imagePath : imagePath(),
      safeToPronounce: safeToPronounce == null ? this.safeToPronounce : safeToPronounce(),
      displayLexicalItemType:
          displayLexicalItemType == null ? this.displayLexicalItemType : displayLexicalItemType(),
      additionalContentPresent: additionalContentPresent == null
          ? this.additionalContentPresent
          : additionalContentPresent(),
      flowCompleted: flowCompleted == null ? this.flowCompleted : flowCompleted(),
    );
  }
}
