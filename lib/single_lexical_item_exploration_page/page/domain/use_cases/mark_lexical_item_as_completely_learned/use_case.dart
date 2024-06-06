import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/analytics/lexical_item_mark_as_completely_learned_source.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/mark_as_completely_learned_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/payment_mechanism.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_mark_as_completely_learned/helper.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_lexical_item_update/helper.dart';
import 'package:mobile_app.core/core/domain/repositories/learning_content_repository/repository.dart';
import 'package:mobile_app.core/core/domain/services/amplitude_analytics_service/service.dart';
import 'package:mobile_app.core/core/domain/services/mixpanel_analytics_service/service.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';

part 'results.dart';

abstract class MarkLexicalItemAsCompletelyLearned {
  LexicalItemMarkAsCompletelyLearnedResult call({
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required PaymentMechanism paymentMechanism,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class MarkLexicalItemAsCompletelyLearnedImpl implements MarkLexicalItemAsCompletelyLearned {
  const MarkLexicalItemAsCompletelyLearnedImpl({
    required ApplyLexicalItemMarkAsCompletelyLearned applyLexicalItemMarkAsCompletelyLearned,
    required ApplyLexicalItemUpdate applyLexicalItemUpdate,
    required GetCardActions getCardActions,
    required LearningContentRepository learningContentRepository,
    required AmplitudeAnalyticsService amplitudeAnalyticsService,
    required MixpanelAnalyticsService mixpanelAnalyticsService,
  })  : _applyLexicalItemMarkAsCompletelyLearned = applyLexicalItemMarkAsCompletelyLearned,
        _applyLexicalItemUpdate = applyLexicalItemUpdate,
        _getCardActions = getCardActions,
        _learningContentRepository = learningContentRepository,
        _amplitudeAnalyticsService = amplitudeAnalyticsService,
        _mixpanelAnalyticsService = mixpanelAnalyticsService;

  final ApplyLexicalItemMarkAsCompletelyLearned _applyLexicalItemMarkAsCompletelyLearned;
  final ApplyLexicalItemUpdate _applyLexicalItemUpdate;
  final GetCardActions _getCardActions;

  final LearningContentRepository _learningContentRepository;

  final AmplitudeAnalyticsService _amplitudeAnalyticsService;
  final MixpanelAnalyticsService _mixpanelAnalyticsService;

  @override
  LexicalItemMarkAsCompletelyLearnedResult call({
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required PaymentMechanism paymentMechanism,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final cardAction = currentFlowM.cardActions.firstWhere((cardAction) {
      return cardAction is MarkAsCompletelyLearnedCardAction;
    }) as MarkAsCompletelyLearnedCardAction;

    if (!cardAction.permitted) {
      final notification = PurchasePageOpeningNotification(
        paymentMechanism: paymentMechanism,
      );

      final result = ActionNotPermittedLexicalItemMarkAsCompletelyLearnedResult(
        notification: notification,
      );

      return result;
    }

    _amplitudeAnalyticsService.logLexicalItemMarkedAsCompletelyLearned(
      source: LexicalItemMarkAsCompletelyLearnedSource.singleLexicalItemExplorationPage,
    );

    _mixpanelAnalyticsService.logLexicalItemMarkedAsCompletelyLearned(
      source: LexicalItemMarkAsCompletelyLearnedSource.singleLexicalItemExplorationPage,
    );

    final updatedLexicalItem = _applyLexicalItemMarkAsCompletelyLearned(
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

    final result = SucceededLexicalItemMarkAsCompletelyLearnedResult(
      currentFlowM: updatedCurrentFlowM,
      lexicalItemMap: updatedLexicalItemMap,
      shouldShowSuccessIndicator: true,
    );

    return result;
  }
}
