import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/config/config.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/configurations/pronunciation_configuration.dart';
import 'package:mobile_app.core/core/domain/helpers/get_lexical_item_mistake_report_email_body/helper.dart';
import 'package:mobile_app.core/core/domain/services/email_service/service.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';

part 'results.dart';

abstract class ReportLexicalItemMistakeByEmail {
  LexicalItemMistakeReportByEmailResult call({
    required EmailApp? selectedEmailApp,
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltList<EmailApp> availableEmailApps,
    required PronunciationConfiguration pronunciationConfiguration,
    required String deviceModel,
    required String systemVersion,
    required String appVersion,
  });
}

class ReportLexicalItemMistakeByEmailImpl implements ReportLexicalItemMistakeByEmail {
  const ReportLexicalItemMistakeByEmailImpl({
    required GetLexicalItemMistakeReportEmailBody getLexicalItemMistakeReportEmailBody,
    required EmailService emailService,
  })  : _getLexicalItemMistakeReportEmailBody = getLexicalItemMistakeReportEmailBody,
        _emailService = emailService;

  final GetLexicalItemMistakeReportEmailBody _getLexicalItemMistakeReportEmailBody;
  final EmailService _emailService;

  @override
  LexicalItemMistakeReportByEmailResult call({
    required EmailApp? selectedEmailApp,
    required MainCardContentExplorationFlowM currentFlowM,
    required BuiltList<EmailApp> availableEmailApps,
    required PronunciationConfiguration pronunciationConfiguration,
    required String deviceModel,
    required String systemVersion,
    required String appVersion,
  }) {
    final EmailApp? emailApp;

    if (selectedEmailApp == null) {
      switch (availableEmailApps.length) {
        case 0:
          emailApp = null;

        case 1:
          emailApp = availableEmailApps.first;

        default:
          final notification = EmailAppSelectionDialogOpeningNotification(
            availableEmailApps: availableEmailApps,
          );

          final result = EmailAppSelectionRequiredLexicalItemMistakeReportByEmailResult(
            notification: notification,
          );

          return result;
      }
    } else {
      emailApp = selectedEmailApp;
    }

    final emailBody = _getLexicalItemMistakeReportEmailBody(
      lexicalItem: currentFlowM.lexicalItem,
      pronunciationConfiguration: pronunciationConfiguration,
      deviceModel: deviceModel,
      systemVersion: systemVersion,
      appVersion: appVersion,
    );

    _emailService.sendEmail(
      to: Config().developerEmail,
      subject: Config().mistakeReportEmailSubject,
      body: emailBody,
      emailApp: emailApp,
    );

    const result = SucceededLexicalItemMistakeReportByEmailResult();

    return result;
  }
}
