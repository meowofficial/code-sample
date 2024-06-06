import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/analytics/lexical_item_addition_to_learning_queue_source.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/addition_to_learning_queue_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/payment_mechanism.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_addition_to_learning_queue/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_update/helper.dart';
import 'package:mobile_app.core/core/domain/repositories/learning_content_repository/repository.dart';
import 'package:mobile_app.core/core/domain/services/amplitude_analytics_service/service.dart';
import 'package:mobile_app.core/core/domain/services/mixpanel_analytics_service/service.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';

part 'results.dart';

abstract class AddLexicalItemToLearningQueue {
  LexicalItemAdditionToLearningQueueResult call({
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required PaymentMechanism paymentMechanism,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class AddLexicalItemToLearningQueueImpl implements AddLexicalItemToLearningQueue {
  const AddLexicalItemToLearningQueueImpl({
    required ApplyLexicalItemAdditionToLearningQueue applyLexicalItemAdditionToLearningQueue,
    required ApplyLexicalItemUpdate applyLexicalItemUpdate,
    required GetCardActions getCardActions,
    required LearningContentRepository learningContentRepository,
    required AmplitudeAnalyticsService amplitudeAnalyticsService,
    required MixpanelAnalyticsService mixpanelAnalyticsService,
  })  : _applyLexicalItemAdditionToLearningQueue = applyLexicalItemAdditionToLearningQueue,
        _applyLexicalItemUpdate = applyLexicalItemUpdate,
        _getCardActions = getCardActions,
        _learningContentRepository = learningContentRepository,
        _amplitudeAnalyticsService = amplitudeAnalyticsService,
        _mixpanelAnalyticsService = mixpanelAnalyticsService;

  final ApplyLexicalItemAdditionToLearningQueue _applyLexicalItemAdditionToLearningQueue;
  final ApplyLexicalItemUpdate _applyLexicalItemUpdate;
  final GetCardActions _getCardActions;

  final LearningContentRepository _learningContentRepository;

  final AmplitudeAnalyticsService _amplitudeAnalyticsService;
  final MixpanelAnalyticsService _mixpanelAnalyticsService;

  @override
  LexicalItemAdditionToLearningQueueResult call({
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required PaymentMechanism paymentMechanism,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final cardAction = currentFlowM.cardActions.firstWhere((cardAction) {
      return cardAction is AdditionToLearningQueueCardAction;
    }) as AdditionToLearningQueueCardAction;

    if (!cardAction.permitted) {
      final notification = PurchasePageOpeningNotification(
        paymentMechanism: paymentMechanism,
      );

      final result = ActionNotPermittedLexicalItemAdditionToLearningQueueResult(
        notification: notification,
      );

      return result;
    }

    _amplitudeAnalyticsService.logLexicalItemAddedToLearningQueue(
      source: LexicalItemAdditionToLearningQueueSource.singleLexicalItemExplorationPage,
    );

    _mixpanelAnalyticsService.logLexicalItemAddedToLearningQueue(
      source: LexicalItemAdditionToLearningQueueSource.singleLexicalItemExplorationPage,
    );

    final updatedLexicalItem = _applyLexicalItemAdditionToLearningQueue(
      lexicalItem: currentFlowM.lexicalItem,
    );

    final updatedLexicalItemMap = _applyLexicalItemUpdate(
      updatedLexicalItem: updatedLexicalItem,
      lexicalItemMap: lexicalItemMap,
    );

    unawaited(_learningContentRepository.saveLexicalItems(
      lexicalItems: updatedLexicalItemMap.values.toBuiltList(),
    ));

    final updatedCardActions = _getCardActions(
      lexicalItem: updatedLexicalItem,
      lexicalItemMap: updatedLexicalItemMap,
      collectionListItems: collectionListItems,
      premiumAccessStatus: premiumAccessStatus,
      availableEmailApps: availableEmailApps,
    );

    final updatedCurrentFlowM = currentFlowM.copyWith(
      lexicalItem: () => updatedLexicalItem,
      cardActions: () => updatedCardActions,
    );

    final result = SucceededLexicalItemAdditionToLearningQueueResult(
      currentFlowM: updatedCurrentFlowM,
      lexicalItemMap: updatedLexicalItemMap,
      shouldShowSuccessIndicator: true,
    );

    return result;
  }
}
