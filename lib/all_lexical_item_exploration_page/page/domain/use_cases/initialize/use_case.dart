import 'package:mobile_app.core/core/domain/services/amplitude_analytics_service/service.dart';
import 'package:mobile_app.core/core/domain/services/mixpanel_analytics_service/service.dart';

abstract interface class Initialize {
  void call();
}

class InitializeImpl implements Initialize {
  const InitializeImpl({
    required AmplitudeAnalyticsService amplitudeAnalyticsService,
    required MixpanelAnalyticsService mixpanelAnalyticsService,
  })  : _amplitudeAnalyticsService = amplitudeAnalyticsService,
        _mixpanelAnalyticsService = mixpanelAnalyticsService;

  final AmplitudeAnalyticsService _amplitudeAnalyticsService;
  final MixpanelAnalyticsService _mixpanelAnalyticsService;

  @override
  void call() {
    _amplitudeAnalyticsService.logAllLexicalItemExplorationPageOpened();
    _mixpanelAnalyticsService.logAllLexicalItemExplorationPageOpened();
  }
}
