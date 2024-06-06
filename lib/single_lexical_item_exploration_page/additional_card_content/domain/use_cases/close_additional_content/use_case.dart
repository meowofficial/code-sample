import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/entities/additional_card_content_notifications.dart';

part 'result.dart';

abstract interface class CloseAdditionalContent {
  AdditionalContentClosingResult? call({
    required bool flowCompleted,
  });
}

class CloseAdditionalContentImpl implements CloseAdditionalContent {
  const CloseAdditionalContentImpl();

  @override
  AdditionalContentClosingResult? call({
    required bool flowCompleted,
  }) {
    if (flowCompleted) {
      return null;
    }

    const notification = AdditionalContentClosingNotification();

    const result = AdditionalContentClosingResult(
      flowCompleted: true,
      notification: notification,
    );

    return result;
  }
}
