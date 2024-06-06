import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_app.core/components/app_action_dialog/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_action/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_action_text/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_cancellation_action/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_message/presentation/component.dart';
import 'package:mobile_app.core/core/domain/entities/ui_locale.dart';
import 'package:mobile_app.core/core/presentation/helpers/show_dialogs.dart';
import 'package:mobile_app.core/core/presentation/size_configs/app_action_dialog_size_config.dart';
import 'package:mobile_app.core/core/presentation/themes/app_action_dialog_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/themes/core_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/translations/app_translation.dart';

part 'translation.dart';

Future<bool?> showOrphanCustomLexicalItemDeletionConfirmationDialog() async {
  return showAppActionDialog<bool>(
    builder: (context) {
      return Localizations.override(
        context: context,
        delegates: const [
          _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation.delegate,
        ],
        child: AppActionDialogTheme(
          brightness: CoreTheme.of(context).brightness,
          child: Builder(
            builder: (context) {
              final translation =
                  _OrphanCustomLexicalItemDeletionConfirmationDialogTranslation.of(context);

              final message = translation.message;

              final messageTextStyle =
                  AppActionDialogTheme.of(context).textTheme.message(
                        fontSize: AppActionDialogSizeConfig.getMessageFontSize(),
                      );

              final actionTitle = translation.confirmationAnswer;

              final actionTextStyle =
                  AppActionDialogTheme.of(context).textTheme.actionTitle(
                        fontSize: AppActionDialogSizeConfig.getActionTitleFontSize(),
                        isDefaultAction: false,
                        isDestructiveAction: true,
                      );

              return AppActionDialog(
                message: AppActionDialogMessage(
                  message,
                  style: messageTextStyle,
                ),
                actions: [
                  AppActionDialogAction(
                    minHeight: AppActionDialogSizeConfig.getActionMinHeight(),
                    padding: AppActionDialogSizeConfig.getActionPadding(),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: AppActionDialogActionText(
                      actionTitle,
                      style: actionTextStyle,
                    ),
                  ),
                ],
                cancellationAction: AppActionDialogCancellationAction(
                  fontSize: AppActionDialogSizeConfig.getActionTitleFontSize(),
                  minHeight: AppActionDialogSizeConfig.getActionMinHeight(),
                  padding: AppActionDialogSizeConfig.getActionPadding(),
                  onPressed: Navigator.of(context).pop,
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
