import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/helpers/is_lexical_item_safe_to_pronounce/helper.dart';

part 'result.dart';

abstract class HandleDialectOuterUpdate {
  DialectOuterUpdateHandlingResult call({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
  });
}

class HandleDialectOuterUpdateImpl implements HandleDialectOuterUpdate {
  const HandleDialectOuterUpdateImpl({
    required IsLexicalItemSafeToPronounce isLexicalItemSafeToPronounce,
  }) : _isLexicalItemSafeToPronounce = isLexicalItemSafeToPronounce;

  final IsLexicalItemSafeToPronounce _isLexicalItemSafeToPronounce;

  @override
  DialectOuterUpdateHandlingResult call({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
  }) {
    final safeToPronounce = _isLexicalItemSafeToPronounce(
      lexicalItem: lexicalItem,
      dialect: dialect,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
    );

    final result = DialectOuterUpdateHandlingResult(
      safeToPronounce: safeToPronounce,
      dialect: dialect,
    );

    return result;
  }
}
