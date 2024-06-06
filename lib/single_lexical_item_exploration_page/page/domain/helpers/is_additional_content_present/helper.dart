import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';

abstract interface class IsAdditionalContentPresent {
  bool call({
    required LexicalItem lexicalItem,
  });
}

class IsAdditionalContentPresentImpl implements IsAdditionalContentPresent {
  const IsAdditionalContentPresentImpl();

  @override
  bool call({
    required LexicalItem lexicalItem,
  }) {
    return lexicalItem.usageExamples.isNotEmpty;
  }
}
