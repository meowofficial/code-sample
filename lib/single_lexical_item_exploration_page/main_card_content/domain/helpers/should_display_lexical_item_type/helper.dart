import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';

abstract class ShouldDisplayLexicalItemType {
  bool call({
    required LexicalItem lexicalItem,
  });
}

class ShouldDisplayLexicalItemTypeImpl implements ShouldDisplayLexicalItemType {
  const ShouldDisplayLexicalItemTypeImpl();

  @override
  bool call({
    required LexicalItem lexicalItem,
  }) {
    return lexicalItem is InbuiltLexicalItem;
  }
}
