part of 'flow_m.dart';

class MainCardContentExplorationFlowM extends Equatable implements FlowM {
  const MainCardContentExplorationFlowM({
    required this.lexicalItem,
    required this.dialect,
    required this.additionalContentPresent,
    required this.imageEnablementEffective,
    required this.cachedImagePathMap,
    required this.unsafeToPronounceLexicalItemTitleMap,
    required this.cardActions,
  });

  final LexicalItem lexicalItem;
  final Dialect dialect;
  final bool additionalContentPresent;
  final bool imageEnablementEffective;
  final BuiltMap<String, String> cachedImagePathMap;
  final BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap;
  final BuiltList<CardAction> cardActions;

  @override
  List<Object?> get props {
    return [
      lexicalItem,
      dialect,
      additionalContentPresent,
      imageEnablementEffective,
      cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap,
      cardActions,
    ];
  }

  MainCardContentExplorationFlowM copyWith({
    LexicalItem Function()? lexicalItem,
    Dialect Function()? dialect,
    bool Function()? additionalContentPresent,
    bool Function()? imageEnablementEffective,
    BuiltMap<String, String> Function()? cachedImagePathMap,
    BuiltMap<Dialect, BuiltSet<String>> Function()? unsafeToPronounceLexicalItemTitleMap,
    BuiltList<CardAction> Function()? cardActions,
  }) {
    return MainCardContentExplorationFlowM(
      lexicalItem: lexicalItem == null ? this.lexicalItem : lexicalItem(),
      dialect: dialect == null ? this.dialect : dialect(),
      additionalContentPresent: additionalContentPresent == null
          ? this.additionalContentPresent
          : additionalContentPresent(),
      imageEnablementEffective: imageEnablementEffective == null
          ? this.imageEnablementEffective
          : imageEnablementEffective(),
      cachedImagePathMap:
          cachedImagePathMap == null ? this.cachedImagePathMap : cachedImagePathMap(),
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap == null
          ? this.unsafeToPronounceLexicalItemTitleMap
          : unsafeToPronounceLexicalItemTitleMap(),
      cardActions: cardActions == null ? this.cardActions : cardActions(),
    );
  }
}
