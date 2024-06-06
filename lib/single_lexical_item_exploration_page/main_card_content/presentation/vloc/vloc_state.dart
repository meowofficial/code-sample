part of 'vloc.dart';

class MainCardContentVlocState extends Equatable {
  const MainCardContentVlocState({
    required this.lexicalItem,
    required this.imagePath,
    required this.dialect,
    required this.safeToPronounce,
    required this.displayLexicalItemType,
    required this.additionalContentPresent,
    required this.allowScrollingToBottom,
    required this.allowScrollingToTop,
  });

  final LexicalItem lexicalItem;
  final String? imagePath;
  final Dialect dialect;
  final bool safeToPronounce;
  final bool displayLexicalItemType;
  final bool additionalContentPresent;
  final bool allowScrollingToBottom;
  final bool allowScrollingToTop;

  @override
  List<Object?> get props {
    return [
      lexicalItem,
      imagePath,
      dialect,
      safeToPronounce,
      displayLexicalItemType,
      additionalContentPresent,
      allowScrollingToBottom,
      allowScrollingToTop,
    ];
  }

  MainCardContentVlocState copyWith({
    LexicalItem Function()? lexicalItem,
    String? Function()? imagePath,
    Dialect Function()? dialect,
    bool Function()? safeToPronounce,
    bool Function()? displayLexicalItemType,
    bool Function()? additionalContentPresent,
    bool Function()? allowScrollingToBottom,
    bool Function()? allowScrollingToTop,
  }) {
    return MainCardContentVlocState(
      lexicalItem: lexicalItem == null ? this.lexicalItem : lexicalItem(),
      imagePath: imagePath == null ? this.imagePath : imagePath(),
      dialect: dialect == null ? this.dialect : dialect(),
      safeToPronounce: safeToPronounce == null ? this.safeToPronounce : safeToPronounce(),
      displayLexicalItemType:
          displayLexicalItemType == null ? this.displayLexicalItemType : displayLexicalItemType(),
      additionalContentPresent: additionalContentPresent == null
          ? this.additionalContentPresent
          : additionalContentPresent(),
      allowScrollingToBottom:
          allowScrollingToBottom == null ? this.allowScrollingToBottom : allowScrollingToBottom(),
      allowScrollingToTop:
          allowScrollingToTop == null ? this.allowScrollingToTop : allowScrollingToTop(),
    );
  }
}
