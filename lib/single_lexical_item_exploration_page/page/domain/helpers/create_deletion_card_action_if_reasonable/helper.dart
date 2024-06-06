import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/deletion_card_action.dart';

abstract class CreateDeletionCardActionIfReasonable {
  DeletionCardAction? call({
    required LexicalItem lexicalItem,
  });
}

class CreateDeletionCardActionIfReasonableImpl implements CreateDeletionCardActionIfReasonable {
  const CreateDeletionCardActionIfReasonableImpl();

  @override
  DeletionCardAction? call({
    required LexicalItem lexicalItem,
  }) {
    if (lexicalItem is! CustomLexicalItem) {
      return null;
    }

    return const DeletionCardAction();
  }
}
