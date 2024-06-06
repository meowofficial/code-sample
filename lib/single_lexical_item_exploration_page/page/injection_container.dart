import 'package:get_it/get_it.dart';
import 'package:mobile_app.core/injection_container.dart' as core_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/injection_container.dart'
    as additional_card_content_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/injection_container.dart'
    as main_card_content_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/create_deletion_card_action_if_reasonable/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/is_additional_content_present/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/is_custom_lexical_item_used_in_any_collection/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/add_lexical_item_to_custom_collection/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/add_lexical_item_to_learning_queue/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/cancel_flow_change/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/close_additional_content/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/complete_flow_change/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/delete_custom_lexical_item/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/exclude_lexical_item_from_learning/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/get_initial_data/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/handle_available_email_app_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/handle_cached_image_path_map_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/handle_dialect_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/handle_image_enablement_effective_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/handle_learning_content_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/handle_premium_access_status_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/initialize/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/mark_lexical_item_as_completely_learned/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/mark_lexical_item_as_known/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/open_card_action_dialog/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/open_custom_lexical_item_editing_dialog/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/remove_lexical_item_from_learning_queue/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/report_lexical_item_mistake/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/report_lexical_item_mistake_by_email/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/report_lexical_item_mistake_through_telegram/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/reset_lexical_item_progress/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/return_lexical_item_to_learning/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/reveal_additional_content/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/use_cases/update_custom_lexical_item/use_case.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  await Future.wait([
    main_card_content_di.init(),
    additional_card_content_di.init(),
  ]);

  // domain helpers

  sl.registerLazySingleton<CreateDeletionCardActionIfReasonable>(() {
    return const CreateDeletionCardActionIfReasonableImpl();
  });

  sl.registerLazySingleton<GetCardActions>(() {
    return GetCardActionsImpl(
      createAdditionToCustomCollectionCardActionIfReasonable: core_di.sl(),
      createAdditionToLearningQueueCardActionIfReasonable: core_di.sl(),
      createEditingCardActionIfReasonable: core_di.sl(),
      createExclusionFromLearningCardActionIfReasonable: core_di.sl(),
      createMarkAsCompletelyLearnedCardActionIfReasonable: core_di.sl(),
      createMarkAsKnownCardActionIfReasonable: core_di.sl(),
      createMistakeReportCardActionIfReasonable: core_di.sl(),
      createProgressResetCardActionIfReasonable: core_di.sl(),
      createDeletionCardActionIfReasonable: sl(),
      createRemovalFromLearningQueueCardActionIfReasonable: core_di.sl(),
      createReturnToLearningCardActionIfReasonable: core_di.sl(),
      getPermittedCollectionListItemIds: core_di.sl(),
      getPermittedLexicalItemIds: core_di.sl(),
    );
  });

  sl.registerLazySingleton<IsAdditionalContentPresent>(() {
    return const IsAdditionalContentPresentImpl();
  });

  sl.registerLazySingleton<IsCustomLexicalItemUsedInAnyCollection>(() {
    return const IsCustomLexicalItemUsedInAnyCollectionImpl();
  });

  // use cases

  sl.registerLazySingleton<AddLexicalItemToCustomCollection>(() {
    return AddLexicalItemToCustomCollectionImpl(
      learningContentRepository: core_di.sl(),
      applyCollectionListItemUpdate: core_di.sl(),
      applyLexicalItemAdditionToCustomCollection: core_di.sl(),
      getCardActions: sl(),
    );
  });

  sl.registerLazySingleton<AddLexicalItemToLearningQueue>(() {
    return AddLexicalItemToLearningQueueImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemAdditionToLearningQueue: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<CancelFlowChange>(() {
    return const CancelFlowChangeImpl();
  });

  sl.registerLazySingleton<CloseAdditionalContent>(() {
    return CloseAdditionalContentImpl(
      getCardActions: sl(),
      imageService: core_di.sl(),
      isAdditionalContentPresent: sl(),
    );
  });

  sl.registerLazySingleton<CompleteFlowChange>(() {
    return CompleteFlowChangeImpl(
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<DeleteCustomLexicalItem>(() {
    return DeleteCustomLexicalItemImpl(
      learningContentRepository: core_di.sl(),
      applyAllCollectionListItemNonexistentLexicalItemRemoval: core_di.sl(),
      isCustomLexicalItemUsedInAnyCollection: sl(),
    );
  });

  sl.registerLazySingleton<ExcludeLexicalItemFromLearning>(() {
    return ExcludeLexicalItemFromLearningImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemExclusionFromLearning: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<GetInitialData>(() {
    return GetInitialDataImpl(
      getCardActions: sl(),
      imageService: core_di.sl(),
      isAdditionalContentPresent: sl(),
    );
  });

  sl.registerLazySingleton<HandleAvailableEmailAppOuterUpdate>(() {
    return HandleAvailableEmailAppOuterUpdateImpl(
      getCardActions: sl(),
    );
  });

  sl.registerLazySingleton<HandleCachedImagePathMapOuterUpdate>(() {
    return const HandleCachedImagePathMapOuterUpdateImpl();
  });

  sl.registerLazySingleton<HandleDialectOuterUpdate>(() {
    return const HandleDialectOuterUpdateImpl();
  });

  sl.registerLazySingleton<HandleImageEnablementEffectiveOuterUpdate>(() {
    return const HandleImageEnablementEffectiveOuterUpdateImpl();
  });

  sl.registerLazySingleton<HandleLearningContentOuterUpdate>(() {
    return HandleLearningContentOuterUpdateImpl(
      getCardActions: sl(),
      isAdditionalContentPresent: sl(),
      imageService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<HandlePremiumAccessStatusOuterUpdate>(() {
    return HandlePremiumAccessStatusOuterUpdateImpl(
      getCardActions: sl(),
    );
  });

  sl.registerLazySingleton<Initialize>(() {
    return InitializeImpl(
      imageService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<MarkLexicalItemAsCompletelyLearned>(() {
    return MarkLexicalItemAsCompletelyLearnedImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemMarkAsCompletelyLearned: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<MarkLexicalItemAsKnown>(() {
    return MarkLexicalItemAsKnownImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemMarkAsKnown: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<OpenCardActionDialog>(() {
    return const OpenCardActionDialogImpl();
  });

  sl.registerLazySingleton<OpenCustomLexicalItemEditingDialog>(() {
    return const OpenCustomLexicalItemEditingDialogImpl();
  });

  sl.registerLazySingleton<RemoveLexicalItemFromLearningQueue>(() {
    return RemoveLexicalItemFromLearningQueueImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemRemovalFromLearningQueue: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
    );
  });

  sl.registerLazySingleton<ReportLexicalItemMistake>(() {
    return const ReportLexicalItemMistakeImpl();
  });

  sl.registerLazySingleton<ReportLexicalItemMistakeByEmail>(() {
    return ReportLexicalItemMistakeByEmailImpl(
      emailService: core_di.sl(),
      getLexicalItemMistakeReportEmailBody: core_di.sl(),
    );
  });

  sl.registerLazySingleton<ReportLexicalItemMistakeThroughTelegram>(() {
    return ReportLexicalItemMistakeThroughTelegramImpl(
      urlLauncher: core_di.sl(),
    );
  });

  sl.registerLazySingleton<ResetLexicalItemProgress>(() {
    return ResetLexicalItemProgressImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemProgressReset: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<ReturnLexicalItemToLearning>(() {
    return ReturnLexicalItemToLearningImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemReturnToLearning: core_di.sl(),
      applyLexicalItemUpdate: core_di.sl(),
    );
  });

  sl.registerLazySingleton<RevealAdditionalContent>(() {
    return const RevealAdditionalContentImpl();
  });

  sl.registerLazySingleton<UpdateCustomLexicalItem>(() {
    return UpdateCustomLexicalItemImpl(
      learningContentRepository: core_di.sl(),
      getCardActions: sl(),
      applyLexicalItemUpdate: core_di.sl(),
      isAdditionalContentPresent: sl(),
    );
  });
}
