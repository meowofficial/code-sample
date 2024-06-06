import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';

part 'result.dart';

abstract interface class OpenCustomLexicalItemEditingDialog {
  CustomLexicalItemEditingDialogOpeningResult call({
    required MainCardContentExplorationFlowM currentFlowM,
  });
}

class OpenCustomLexicalItemEditingDialogImpl implements OpenCustomLexicalItemEditingDialog {
  const OpenCustomLexicalItemEditingDialogImpl();

  @override
  CustomLexicalItemEditingDialogOpeningResult call({
    required MainCardContentExplorationFlowM currentFlowM,
  }) {
    final notification = CustomLexicalItemEditingDialogOpeningNotification(
      lexicalItem: currentFlowM.lexicalItem as CustomLexicalItem,
    );

    final result = CustomLexicalItemEditingDialogOpeningResult(
      notification: notification,
    );

    return result;
  }
}
