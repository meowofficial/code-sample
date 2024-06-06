import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/analytics/card_additional_content_revealing_source.dart';
import 'package:mobile_app.core/core/domain/services/amplitude_analytics_service/service.dart';
import 'package:mobile_app.core/core/domain/services/mixpanel_analytics_service/service.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_tms/flow_tm.dart';

part 'result.dart';

abstract class CompleteFlowChange {
  FlowChangeCompletionResult call({
    required FlowM nextFlowM,
    required FlowTM flowTM,
  });
}

class CompleteFlowChangeImpl implements CompleteFlowChange {
  const CompleteFlowChangeImpl({
    required AmplitudeAnalyticsService amplitudeAnalyticsService,
    required MixpanelAnalyticsService mixpanelAnalyticsService,
  })  : _amplitudeAnalyticsService = amplitudeAnalyticsService,
        _mixpanelAnalyticsService = mixpanelAnalyticsService;

  final AmplitudeAnalyticsService _amplitudeAnalyticsService;
  final MixpanelAnalyticsService _mixpanelAnalyticsService;

  @override
  FlowChangeCompletionResult call({
    required FlowM nextFlowM,
    required FlowTM flowTM,
  }) {
    switch (flowTM) {
      case MainToAdditionalCardContentExplorationFlowTM():
        _amplitudeAnalyticsService.logCardAdditionalContentRevealed(
          source: CardAdditionalContentRevealingSource.singleLexicalItemExplorationPage,
          method: flowTM.method,
        );

        _mixpanelAnalyticsService.logCardAdditionalContentRevealed(
          source: CardAdditionalContentRevealingSource.singleLexicalItemExplorationPage,
          method: flowTM.method,
        );

      case AdditionalToMainCardContentExplorationFlowTM():
        break;
    }

    final result = FlowChangeCompletionResult(
      currentFlowM: nextFlowM,
      nextFlowM: null,
      flowTM: null,
    );

    return result;
  }
}
