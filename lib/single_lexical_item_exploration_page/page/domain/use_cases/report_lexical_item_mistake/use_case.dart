import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/mistake_report_card_action.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';

part 'result.dart';

abstract class ReportLexicalItemMistake {
  LexicalItemMistakeReportResult call({
    required MainCardContentExplorationFlowM currentFlowM,
  });
}

class ReportLexicalItemMistakeImpl implements ReportLexicalItemMistake {
  const ReportLexicalItemMistakeImpl();

  @override
  LexicalItemMistakeReportResult call({
    required MainCardContentExplorationFlowM currentFlowM,
  }) {
    final cardAction = currentFlowM.cardActions.firstWhere((cardAction) {
      return cardAction is MistakeReportCardAction;
    }) as MistakeReportCardAction;

    final notification = MistakeReportMethodSelectionDialogOpeningNotification(
      methods: cardAction.methods,
    );

    final result = LexicalItemMistakeReportResult(
      notification: notification,
    );

    return result;
  }
}
