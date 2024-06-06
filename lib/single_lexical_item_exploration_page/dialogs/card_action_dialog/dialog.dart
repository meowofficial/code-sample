import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_app.core/components/app_action_dialog/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_action/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_action_text/presentation/component.dart';
import 'package:mobile_app.core/components/app_action_dialog_cancellation_action/presentation/component.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/addition_to_collection_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/addition_to_learning_queue_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/editing_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/exclusion_from_learning_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/mark_as_completely_learned_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/mark_as_known_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/mistake_report_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/progress_reset_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/removal_from_learning_queue_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/return_to_learning_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/ui_locale.dart';
import 'package:mobile_app.core/core/presentation/helpers/card_action_builders.dart';
import 'package:mobile_app.core/core/presentation/helpers/show_dialogs.dart';
import 'package:mobile_app.core/core/presentation/size_configs/app_action_dialog_size_config.dart';
import 'package:mobile_app.core/core/presentation/themes/app_action_dialog_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/themes/core_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/translations/app_translation.dart';
import 'package:mobile_app.core/core/presentation/translations/card_action_translation.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/deletion_card_action.dart';

part 'translation.dart';

Future<CardAction?> showCardActionDialog({
  required BuiltList<CardAction> cardActions,
}) async {
  return showAppActionDialog<CardAction>(
    builder: (context) {
      return Localizations.override(
        context: context,
        delegates: const [
          CardActionTranslation.delegate,
          _CardActionDialogTranslation.delegate,
        ],
        child: AppActionDialogTheme(
          brightness: CoreTheme.of(context).brightness,
          child: Builder(
            builder: (context) {
              return AppActionDialog(
                actions: cardActions.map((cardAction) {
                  switch (cardAction) {
                    case MistakeReportCardAction():
                      return buildMistakeReportCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case ProgressResetCardAction():
                      return buildProgressResetCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case MarkAsKnownCardAction():
                      return buildMarkAsKnownCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case MarkAsCompletelyLearnedCardAction():
                      return buildMarkAsCompletelyLearnedCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case AdditionToLearningQueueCardAction():
                      return buildAdditionToLearningQueueCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case RemovalFromLearningQueueCardAction():
                      return buildRemovalFromLearningQueueCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case ReturnToLearningCardAction():
                      return buildReturnToLearningCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case AdditionToCustomCollectionCardAction():
                      return buildAdditionToCustomCollectionCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case ExclusionFromLearningCardAction():
                      return buildExclusionFromLearningCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case EditingCardAction():
                      return buildEditingCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    case DeletionCardAction():
                      return _buildDeletionCardAction(
                        context: context,
                        cardAction: cardAction,
                        onPressed: () {
                          Navigator.of(context).pop(cardAction);
                        },
                      );

                    default:
                      return throw UnimplementedError();
                  }
                }).toList(),
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

AppActionDialogAction _buildDeletionCardAction({
  required BuildContext context,
  required DeletionCardAction cardAction,
  required VoidCallback onPressed,
}) {
  final title = _CardActionDialogTranslation.of(context).deletionCardActionTitle;

  final textStyle = AppActionDialogTheme.of(context).textTheme.actionTitle(
        fontSize: AppActionDialogSizeConfig.getActionTitleFontSize(),
        isDefaultAction: false,
        isDestructiveAction: true,
      );

  return AppActionDialogAction(
    onPressed: onPressed,
    minHeight: AppActionDialogSizeConfig.getActionMinHeight(),
    padding: AppActionDialogSizeConfig.getActionPadding(),
    child: AppActionDialogActionText(
      title,
      style: textStyle,
    ),
  );
}
