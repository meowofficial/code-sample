import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/helpers/get_lexical_item_effective_image_path/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/is_lexical_item_safe_to_pronounce/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/helpers/should_display_lexical_item_type/helper.dart';

part 'result.dart';

abstract class HandleLexicalItemOuterUpdate {
  LexicalItemOuterUpdateHandlingResult call({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required bool imageEnablementEffective,
    required BuiltMap<String, String> cachedImagePathMap,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
  });
}

class HandleLexicalItemOuterUpdateImpl implements HandleLexicalItemOuterUpdate {
  const HandleLexicalItemOuterUpdateImpl({
    required GetLexicalItemEffectiveImagePath getLexicalItemEffectiveImagePath,
    required IsLexicalItemSafeToPronounce isLexicalItemSafeToPronounce,
    required ShouldDisplayLexicalItemType shouldDisplayLexicalItemType,
  })  : _getLexicalItemEffectiveImagePath = getLexicalItemEffectiveImagePath,
        _isLexicalItemSafeToPronounce = isLexicalItemSafeToPronounce,
        _shouldDisplayLexicalItemType = shouldDisplayLexicalItemType;

  final GetLexicalItemEffectiveImagePath _getLexicalItemEffectiveImagePath;
  final IsLexicalItemSafeToPronounce _isLexicalItemSafeToPronounce;
  final ShouldDisplayLexicalItemType _shouldDisplayLexicalItemType;

  @override
  LexicalItemOuterUpdateHandlingResult call({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required bool imageEnablementEffective,
    required BuiltMap<String, String> cachedImagePathMap,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
  }) {
    final imagePath = _getLexicalItemEffectiveImagePath(
      lexicalItem: lexicalItem,
      cachedImagePathMap: cachedImagePathMap,
      imageEnablementEffective: imageEnablementEffective,
    );

    final safeToPronounce = _isLexicalItemSafeToPronounce(
      lexicalItem: lexicalItem,
      dialect: dialect,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
    );

    final displayLexicalItemType = _shouldDisplayLexicalItemType(
      lexicalItem: lexicalItem,
    );

    final result = LexicalItemOuterUpdateHandlingResult(
      lexicalItem: lexicalItem,
      imagePath: imagePath,
      safeToPronounce: safeToPronounce,
      displayLexicalItemType: displayLexicalItemType,
    );

    return result;
  }
}
