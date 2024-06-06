import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/entities/main_card_content_notifications.dart';

part 'result.dart';

abstract interface class OpenCardActionDialog {
  CardActionDialogOpeningResult call();
}

class OpenCardActionDialogImpl implements OpenCardActionDialog {
  const OpenCardActionDialogImpl();

  @override
  CardActionDialogOpeningResult call() {
    const notification = CardActionDialogOpeningNotification();

    const result = CardActionDialogOpeningResult(
      notification: notification,
    );

    return result;
  }
}
