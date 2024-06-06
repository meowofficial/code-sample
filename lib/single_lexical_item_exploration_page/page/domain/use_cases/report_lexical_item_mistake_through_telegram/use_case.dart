import 'package:mobile_app.core/core/domain/config/config.dart';
import 'package:mobile_app.core/core/domain/services/url_launcher/service.dart';

abstract class ReportLexicalItemMistakeThroughTelegram {
  void call({
    required int primaryColorValue,
  });
}

class ReportLexicalItemMistakeThroughTelegramImpl
    implements ReportLexicalItemMistakeThroughTelegram {
  const ReportLexicalItemMistakeThroughTelegramImpl({
    required UrlLauncher urlLauncher,
  }) : _urlLauncher = urlLauncher;

  final UrlLauncher _urlLauncher;

  @override
  void call({
    required int primaryColorValue,
  }) {
    _urlLauncher.launchSchemeUrl(
      schemeUrl: Config().telegramChannelMistakeReportMessageSchemeUrl,
      fallbackBrowserUrl: Config().telegramChannelMistakeReportMessageBrowserUrl,
      fallbackBrowserUrlLaunchMode: UrlLaunchMode.inAppBrowser,
      inAppBrowserPrimaryColorValue: primaryColorValue,
    );
  }
}
