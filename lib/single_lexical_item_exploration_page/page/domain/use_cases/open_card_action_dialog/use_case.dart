import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';

part 'result.dart';

abstract interface class OpenCardActionDialog {
  CardActionDialogOpeningResult call({
    required MainCardContentExplorationFlowM currentFlowM,
  });
}

class OpenCardActionDialogImpl implements OpenCardActionDialog {
  const OpenCardActionDialogImpl();

  @override
  CardActionDialogOpeningResult call({
    required MainCardContentExplorationFlowM currentFlowM,
  }) {
    final notification = CardActionDialogOpeningNotification(
      cardActions: currentFlowM.cardActions,
    );

    final result = CardActionDialogOpeningResult(
      notification: notification,
    );

    return result;
  }
}
