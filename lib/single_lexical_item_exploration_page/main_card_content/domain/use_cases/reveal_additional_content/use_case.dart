import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/entities/main_card_content_notifications.dart';

part 'result.dart';

abstract interface class RevealAdditionalContent {
  AdditionalContentRevealingResult? call({
    required bool flowCompleted,
  });
}

class RevealAdditionalContentImpl implements RevealAdditionalContent {
  const RevealAdditionalContentImpl();

  @override
  AdditionalContentRevealingResult? call({
    required bool flowCompleted,
  }) {
    if (flowCompleted) {
      return null;
    }

    const notification = AdditionalContentRevealingNotification();

    const result = AdditionalContentRevealingResult(
      flowCompleted: true,
      notification: notification,
    );

    return result;
  }
}
