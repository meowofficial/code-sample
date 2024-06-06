import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mobile_app.core/core/application/app_info_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/collection_navigator_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/configuration_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/device_info_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/email_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/learning_content_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/overlay_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/user_info_bloc/bloc.dart';
import 'package:mobile_app.core/core/domain/entities/card_additional_content_closing_method.dart';
import 'package:mobile_app.core/core/domain/entities/card_additional_content_revealing_method.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/page_models/app_navigator_page_model.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_tms/flow_tm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';
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

part 'bloc_state.dart';

class SingleLexicalItemPageBloc extends Cubit<SingleLexicalItemPageBlocState> {
  SingleLexicalItemPageBloc({
    required SingleLexicalItemExplorationPageModel pageModel,
    required LearningContentBloc learningContentBloc,
    required UserInfoBloc userInfoBloc,
    required AppInfoBloc appInfoBloc,
    required DeviceInfoBloc deviceInfoBloc,
    required ConfigurationBloc configurationBloc,
    required OverlayBloc overlayBloc,
    required EmailBloc emailBloc,
    required CollectionNavigatorBloc collectionNavigatorBloc,
    required GetInitialData getInitialData,
    required Initialize initialize,
    required AddLexicalItemToCustomCollection addLexicalItemToCustomCollection,
    required AddLexicalItemToLearningQueue addLexicalItemToLearningQueue,
    required CancelFlowChange cancelFlowChange,
    required CloseAdditionalContent closeAdditionalContent,
    required CompleteFlowChange completeFlowChange,
    required DeleteCustomLexicalItem deleteCustomLexicalItem,
    required ExcludeLexicalItemFromLearning excludeLexicalItemFromLearning,
    required HandleAvailableEmailAppOuterUpdate handleAvailableEmailAppOuterUpdate,
    required HandleCachedImagePathMapOuterUpdate handleCachedImagePathMapOuterUpdate,
    required HandleDialectOuterUpdate handleDialectOuterUpdate,
    required HandleImageEnablementEffectiveOuterUpdate handleImageEnablementEffectiveOuterUpdate,
    required HandleLearningContentOuterUpdate handleLearningContentOuterUpdate,
    required HandlePremiumAccessStatusOuterUpdate handlePremiumAccessStatusOuterUpdate,
    required MarkLexicalItemAsCompletelyLearned markLexicalItemAsCompletelyLearned,
    required MarkLexicalItemAsKnown markLexicalItemAsKnown,
    required OpenCardActionDialog openCardActionDialog,
    required OpenCustomLexicalItemEditingDialog openCustomLexicalItemEditingDialog,
    required RemoveLexicalItemFromLearningQueue removeLexicalItemFromLearningQueue,
    required ReportLexicalItemMistake reportLexicalItemMistake,
    required ReportLexicalItemMistakeByEmail reportLexicalItemMistakeByEmail,
    required ReportLexicalItemMistakeThroughTelegram reportLexicalItemMistakeThroughTelegram,
    required ResetLexicalItemProgress resetLexicalItemProgress,
    required ReturnLexicalItemToLearning returnLexicalItemToLearning,
    required RevealAdditionalContent revealAdditionalContent,
    required UpdateCustomLexicalItem updateCustomLexicalItem,
  })  : _pageModel = pageModel,
        _learningContentBloc = learningContentBloc,
        _userInfoBloc = userInfoBloc,
        _appInfoBloc = appInfoBloc,
        _deviceInfoBloc = deviceInfoBloc,
        _configurationBloc = configurationBloc,
        _emailBloc = emailBloc,
        _overlayBloc = overlayBloc,
        _collectionNavigatorBloc = collectionNavigatorBloc,
        _addLexicalItemToCustomCollection = addLexicalItemToCustomCollection,
        _addLexicalItemToLearningQueue = addLexicalItemToLearningQueue,
        _cancelFlowChange = cancelFlowChange,
        _closeAdditionalContent = closeAdditionalContent,
        _completeFlowChange = completeFlowChange,
        _deleteCustomLexicalItem = deleteCustomLexicalItem,
        _excludeLexicalItemFromLearning = excludeLexicalItemFromLearning,
        _handleAvailableEmailAppOuterUpdate = handleAvailableEmailAppOuterUpdate,
        _handleCachedImagePathMapOuterUpdate = handleCachedImagePathMapOuterUpdate,
        _handleDialectOuterUpdate = handleDialectOuterUpdate,
        _handleImageEnablementEffectiveOuterUpdate = handleImageEnablementEffectiveOuterUpdate,
        _handleLearningContentOuterUpdate = handleLearningContentOuterUpdate,
        _handlePremiumAccessStatusOuterUpdate = handlePremiumAccessStatusOuterUpdate,
        _markLexicalItemAsCompletelyLearned = markLexicalItemAsCompletelyLearned,
        _markLexicalItemAsKnown = markLexicalItemAsKnown,
        _openCardActionDialog = openCardActionDialog,
        _openCustomLexicalItemEditingDialog = openCustomLexicalItemEditingDialog,
        _removeLexicalItemFromLearningQueue = removeLexicalItemFromLearningQueue,
        _reportLexicalItemMistake = reportLexicalItemMistake,
        _reportLexicalItemMistakeByEmail = reportLexicalItemMistakeByEmail,
        _reportLexicalItemMistakeThroughTelegram = reportLexicalItemMistakeThroughTelegram,
        _resetLexicalItemProgress = resetLexicalItemProgress,
        _returnLexicalItemToLearning = returnLexicalItemToLearning,
        _revealAdditionalContent = revealAdditionalContent,
        _updateCustomLexicalItem = updateCustomLexicalItem,
        super(_getInitialState(
          pageModel: pageModel,
          learningContentBlocState: learningContentBloc.state!,
          userInfoBlocState: userInfoBloc.state!,
          configurationBlocState: configurationBloc.state!,
          emailBlocState: emailBloc.state!,
          getInitialData: getInitialData,
        )) {
    final initializationResult = initialize();

    _cachedImagePathMapStreamSubscription =
        initializationResult.cachedImagePathMapStream.listen(_onCachedImagePathMapChanged);

    _learningContentBlocSubscription =
        learningContentBloc.streamWithPrevious.listen(_onLearningContentBlocStateChanged);

    _configurationBlocSubscription =
        configurationBloc.streamWithPrevious.listen(_onConfigurationBlocStateChanged);

    _emailBlocSubscription = emailBloc.streamWithPrevious.listen(_onEmailBlocStateChanged);

    _userInfoBlocSubscription = userInfoBloc.streamWithPrevious.listen(_onUserInfoBlocStateChanged);
  }

  final SingleLexicalItemExplorationPageModel _pageModel;

  final LearningContentBloc _learningContentBloc;
  final UserInfoBloc _userInfoBloc;
  final AppInfoBloc _appInfoBloc;
  final DeviceInfoBloc _deviceInfoBloc;
  final ConfigurationBloc _configurationBloc;
  final EmailBloc _emailBloc;
  final OverlayBloc _overlayBloc;
  final CollectionNavigatorBloc _collectionNavigatorBloc;

  final AddLexicalItemToCustomCollection _addLexicalItemToCustomCollection;
  final AddLexicalItemToLearningQueue _addLexicalItemToLearningQueue;
  final CancelFlowChange _cancelFlowChange;
  final CloseAdditionalContent _closeAdditionalContent;
  final CompleteFlowChange _completeFlowChange;
  final DeleteCustomLexicalItem _deleteCustomLexicalItem;
  final ExcludeLexicalItemFromLearning _excludeLexicalItemFromLearning;
  final HandleAvailableEmailAppOuterUpdate _handleAvailableEmailAppOuterUpdate;
  final HandleCachedImagePathMapOuterUpdate _handleCachedImagePathMapOuterUpdate;
  final HandleDialectOuterUpdate _handleDialectOuterUpdate;
  final HandleImageEnablementEffectiveOuterUpdate _handleImageEnablementEffectiveOuterUpdate;
  final HandleLearningContentOuterUpdate _handleLearningContentOuterUpdate;
  final HandlePremiumAccessStatusOuterUpdate _handlePremiumAccessStatusOuterUpdate;
  final MarkLexicalItemAsCompletelyLearned _markLexicalItemAsCompletelyLearned;
  final MarkLexicalItemAsKnown _markLexicalItemAsKnown;
  final OpenCardActionDialog _openCardActionDialog;
  final OpenCustomLexicalItemEditingDialog _openCustomLexicalItemEditingDialog;
  final RemoveLexicalItemFromLearningQueue _removeLexicalItemFromLearningQueue;
  final ReportLexicalItemMistake _reportLexicalItemMistake;
  final ReportLexicalItemMistakeByEmail _reportLexicalItemMistakeByEmail;
  final ReportLexicalItemMistakeThroughTelegram _reportLexicalItemMistakeThroughTelegram;
  final ResetLexicalItemProgress _resetLexicalItemProgress;
  final ReturnLexicalItemToLearning _returnLexicalItemToLearning;
  final RevealAdditionalContent _revealAdditionalContent;
  final UpdateCustomLexicalItem _updateCustomLexicalItem;

  final _notificationStreamController =
      StreamController<SingleLexicalItemPageNotification>.broadcast();

  late final StreamSubscription<BuiltMap<String, String>> _cachedImagePathMapStreamSubscription;
  late final StreamSubscription<(LearningContentBlocState, LearningContentBlocState?)>
      _learningContentBlocSubscription;
  late final StreamSubscription<(UserInfoBlocState, UserInfoBlocState?)> _userInfoBlocSubscription;
  late final StreamSubscription<(EmailBlocState, EmailBlocState?)> _emailBlocSubscription;
  late final StreamSubscription<(ConfigurationBlocState, ConfigurationBlocState?)>
      _configurationBlocSubscription;

  Stream<SingleLexicalItemPageNotification> get notificationStream =>
      _notificationStreamController.stream;

  static SingleLexicalItemPageBlocState _getInitialState({
    required SingleLexicalItemExplorationPageModel pageModel,
    required LearningContentBlocState learningContentBlocState,
    required UserInfoBlocState userInfoBlocState,
    required ConfigurationBlocState configurationBlocState,
    required EmailBlocState emailBlocState,
    required GetInitialData getInitialData,
  }) {
    final dialect = configurationBlocState.pronunciationConfiguration.dialect;
    final lexicalItemMap = learningContentBlocState.lexicalItemMap;
    final collectionListItems = learningContentBlocState.collectionListItems;
    final availableEmailApps = emailBlocState.availableEmailApps;
    final unsafeToPronounceLexicalItemTitleMap =
        learningContentBlocState.unsafeToPronounceLexicalItemTitleMap;
    final premiumAccessStatus = userInfoBlocState.premiumAccessStatus;
    final imageEnablementEffective =
        configurationBlocState.imageConfiguration.imageEnablementEffective;

    final result = getInitialData(
      lexicalItemId: pageModel.lexicalItemId,
      imageEnablementEffective: imageEnablementEffective,
      lexicalItemMap: lexicalItemMap,
      collectionListItems: collectionListItems,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
      premiumAccessStatus: premiumAccessStatus,
      dialect: dialect,
      availableEmailApps: availableEmailApps,
    );

    return SingleLexicalItemPageBlocState(
      currentFlowM: result.currentFlowM,
      nextFlowM: result.nextFlowM,
      flowTM: result.flowTM,
      lexicalItemDeleted: result.lexicalItemDeleted,
      lexicalItemMap: result.lexicalItemMap,
    );
  }

  void _onCachedImagePathMapChanged(BuiltMap<String, String> cachedImagePathMap) {
    final result = _handleCachedImagePathMapOuterUpdate(
      currentFlowM: state.currentFlowM,
      nextFlowM: state.nextFlowM,
      cachedImagePathMap: cachedImagePathMap,
      lexicalItemDeleted: state.lexicalItemDeleted,
    );

    if (result == null) {
      return;
    }

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      nextFlowM: () => result.nextFlowM,
    );

    emit(updatedState);
  }

  void _onLearningContentBlocStateChanged(
      (LearningContentBlocState, LearningContentBlocState?) valueWithPrevious) {
    final (learningContentBlocState, learningContentBlocPreviousState!) = valueWithPrevious;

    if (identical(learningContentBlocState.lexicalItemMap, state.lexicalItemMap) &&
        identical(learningContentBlocState.collectionListItems,
            learningContentBlocPreviousState.collectionListItems) &&
        identical(learningContentBlocState.unsafeToPronounceLexicalItemTitleMap,
            learningContentBlocPreviousState.unsafeToPronounceLexicalItemTitleMap)) {
      return;
    }

    final lexicalItemId = _pageModel.lexicalItemId;
    final premiumAccessStatus = _userInfoBloc.state!.premiumAccessStatus;
    final collectionListItems = learningContentBlocState.collectionListItems;
    final lexicalItemMap = learningContentBlocState.lexicalItemMap;
    final lexicalItemDeleted = state.lexicalItemDeleted;
    final availableEmailApps = _emailBloc.state!.availableEmailApps;
    final dialect = _configurationBloc.state!.pronunciationConfiguration.dialect;
    final unsafeToPronounceLexicalItemTitleMap =
        _learningContentBloc.state!.unsafeToPronounceLexicalItemTitleMap;
    final imageEnablementEffective =
        _configurationBloc.state!.imageConfiguration.imageEnablementEffective;

    final result = _handleLearningContentOuterUpdate(
      lexicalItemId: lexicalItemId,
      currentFlowM: state.currentFlowM,
      nextFlowM: state.nextFlowM,
      premiumAccessStatus: premiumAccessStatus,
      collectionListItems: collectionListItems,
      lexicalItemMap: lexicalItemMap,
      availableEmailApps: availableEmailApps,
      lexicalItemDeleted: lexicalItemDeleted,
      dialect: dialect,
      imageEnablementEffective: imageEnablementEffective,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
    );

    switch (result) {
      case null:
        return;

      case NonexistentLexicalItemLearningContentOuterUpdateHandlingResult():
        final updatedState = state.copyWith(
          lexicalItemDeleted: () => result.lexicalItemDeleted,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);

      case SucceededLearningContentOuterUpdateHandlingResult():
        final updatedState = state.copyWith(
          currentFlowM: () => result.currentFlowM,
          nextFlowM: () => result.nextFlowM,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);
    }
  }

  void _onUserInfoBlocStateChanged((UserInfoBlocState, UserInfoBlocState?) valueWithPrevious) {
    final (userInfoBlocState, userInfoBlocPreviousState) = valueWithPrevious;

    if (userInfoBlocState.premiumAccessStatus == userInfoBlocPreviousState!.premiumAccessStatus) {
      return;
    }

    final result = _handlePremiumAccessStatusOuterUpdate(
      currentFlowM: state.currentFlowM,
      nextFlowM: state.nextFlowM,
      premiumAccessStatus: userInfoBlocState.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      lexicalItemDeleted: state.lexicalItemDeleted,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    if (result == null) {
      return;
    }

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      nextFlowM: () => result.nextFlowM,
    );

    emit(updatedState);
  }

  void _onEmailBlocStateChanged((EmailBlocState, EmailBlocState?) valueWithPrevious) {
    final (emailBlocState, emailBlocPreviousState) = valueWithPrevious;

    if (emailBlocState.availableEmailApps == emailBlocPreviousState!.availableEmailApps) {
      return;
    }

    final result = _handleAvailableEmailAppOuterUpdate(
      currentFlowM: state.currentFlowM,
      nextFlowM: state.nextFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      lexicalItemDeleted: state.lexicalItemDeleted,
      availableEmailApps: emailBlocState.availableEmailApps,
    );

    if (result == null) {
      return;
    }

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      nextFlowM: () => result.nextFlowM,
    );

    emit(updatedState);
  }

  void _onConfigurationBlocStateChanged(
      (ConfigurationBlocState, ConfigurationBlocState?) valueWithPrevious) {
    final (configurationBlocState, configurationBlocPreviousState!) = valueWithPrevious;

    var updatedState = state;

    if (configurationBlocState.pronunciationConfiguration.dialect !=
        configurationBlocPreviousState.pronunciationConfiguration.dialect) {
      final result = _handleDialectOuterUpdate(
        currentFlowM: updatedState.currentFlowM,
        nextFlowM: updatedState.nextFlowM,
        dialect: configurationBlocState.pronunciationConfiguration.dialect,
        lexicalItemDeleted: state.lexicalItemDeleted,
      );

      if (result != null) {
        updatedState = updatedState.copyWith(
          currentFlowM: () => result.currentFlowM,
          nextFlowM: () => result.nextFlowM,
        );
      }
    }

    if (configurationBlocState.imageConfiguration.imageEnablementEffective !=
        configurationBlocPreviousState.imageConfiguration.imageEnablementEffective) {
      final result = _handleImageEnablementEffectiveOuterUpdate(
        currentFlowM: updatedState.currentFlowM,
        nextFlowM: updatedState.nextFlowM,
        imageEnablementEffective:
            configurationBlocState.imageConfiguration.imageEnablementEffective,
        lexicalItemDeleted: state.lexicalItemDeleted,
      );

      if (result != null) {
        updatedState = updatedState.copyWith(
          currentFlowM: () => result.currentFlowM,
          nextFlowM: () => result.nextFlowM,
        );
      }
    }

    emit(updatedState);
  }

  void requestMistakeReport() {
    final result = _reportLexicalItemMistake(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
    );

    _notificationStreamController.add(result.notification);
  }

  void requestMistakeReportThroughTelegram({
    required int primaryColorValue,
  }) {
    _reportLexicalItemMistakeThroughTelegram(
      primaryColorValue: primaryColorValue,
    );
  }

  void requestMistakeReportByEmail({
    required EmailApp? selectedEmailApp,
  }) {
    final deviceModel = _deviceInfoBloc.state!.deviceModel;
    final systemVersion = _deviceInfoBloc.state!.systemVersion;
    final appVersion = _appInfoBloc.state!.appVersion;
    final availableEmailApps = _emailBloc.state!.availableEmailApps;

    final result = _reportLexicalItemMistakeByEmail(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      pronunciationConfiguration: _configurationBloc.state!.pronunciationConfiguration,
      selectedEmailApp: selectedEmailApp,
      deviceModel: deviceModel,
      systemVersion: systemVersion,
      appVersion: appVersion,
      availableEmailApps: availableEmailApps,
    );

    switch (result) {
      case EmailAppSelectionRequiredLexicalItemMistakeReportByEmailResult():
        _notificationStreamController.add(result.notification);

      case SucceededLexicalItemMistakeReportByEmailResult():
        break;
    }
  }

  void requestProgressReset() {
    final result = _resetLexicalItemProgress(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      lexicalItemMap: () => result.lexicalItemMap,
    );

    emit(updatedState);

    if (result.shouldShowSuccessIndicator) {
      _overlayBloc.showSuccessIndicator();
    }

    _learningContentBloc.updateWith(
      lexicalItemMap: () => result.lexicalItemMap,
    );
  }

  void requestMarkLexicalItemAsKnown() {
    final result = _markLexicalItemAsKnown(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      paymentMechanism: _appInfoBloc.state!.paymentMechanism,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    switch (result) {
      case ActionNotPermittedLexicalItemMarkAsKnownResult():
        _notificationStreamController.add(result.notification);

      case SucceededLexicalItemMarkAsKnownResult():
        final updatedState = state.copyWith(
          currentFlowM: () => result.currentFlowM,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);

        if (result.shouldShowSuccessIndicator) {
          _overlayBloc.showSuccessIndicator();
        }

        _learningContentBloc.updateWith(
          lexicalItemMap: () => result.lexicalItemMap,
        );
    }
  }

  void requestMarkLexicalItemAsCompletelyLearned() {
    final result = _markLexicalItemAsCompletelyLearned(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      paymentMechanism: _appInfoBloc.state!.paymentMechanism,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    switch (result) {
      case ActionNotPermittedLexicalItemMarkAsCompletelyLearnedResult():
        _notificationStreamController.add(result.notification);

      case SucceededLexicalItemMarkAsCompletelyLearnedResult():
        final updatedState = state.copyWith(
          currentFlowM: () => result.currentFlowM,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);

        if (result.shouldShowSuccessIndicator) {
          _overlayBloc.showSuccessIndicator();
        }

        _learningContentBloc.updateWith(
          lexicalItemMap: () => result.lexicalItemMap,
        );
    }
  }

  void requestLexicalItemAdditionToLearningQueue() {
    final result = _addLexicalItemToLearningQueue(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      paymentMechanism: _appInfoBloc.state!.paymentMechanism,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    switch (result) {
      case ActionNotPermittedLexicalItemAdditionToLearningQueueResult():
        _notificationStreamController.add(result.notification);

      case SucceededLexicalItemAdditionToLearningQueueResult():
        final updatedState = state.copyWith(
          currentFlowM: () => result.currentFlowM,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);

        if (result.shouldShowSuccessIndicator) {
          _overlayBloc.showSuccessIndicator();
        }

        _learningContentBloc.updateWith(
          lexicalItemMap: () => result.lexicalItemMap,
        );
    }
  }

  void requestLexicalItemRemovalFromLearningQueue() {
    final result = _removeLexicalItemFromLearningQueue(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      lexicalItemMap: () => result.lexicalItemMap,
    );

    emit(updatedState);

    if (result.shouldShowSuccessIndicator) {
      _overlayBloc.showSuccessIndicator();
    }

    _learningContentBloc.updateWith(
      lexicalItemMap: () => result.lexicalItemMap,
    );
  }

  void requestLexicalItemReturnToLearning() {
    final result = _returnLexicalItemToLearning(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      lexicalItemMap: () => result.lexicalItemMap,
    );

    emit(updatedState);

    if (result.shouldShowSuccessIndicator) {
      _overlayBloc.showSuccessIndicator();
    }

    _learningContentBloc.updateWith(
      lexicalItemMap: () => result.lexicalItemMap,
    );
  }

  void requestLexicalItemAdditionToCustomCollection({
    String? selectedCustomCollectionId,
  }) {
    final result = _addLexicalItemToCustomCollection(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      selectedCustomCollectionId: selectedCustomCollectionId,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      paymentMechanism: _appInfoBloc.state!.paymentMechanism,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    switch (result) {
      case ActionNotPermittedLexicalItemAdditionToCustomCollectionResult():
        _notificationStreamController.add(result.notification);

      case CollectionSelectionRequiredLexicalItemAdditionToCustomCollectionResult():
        _notificationStreamController.add(result.notification);

      case SucceededLexicalItemAdditionToCustomCollectionResult():
        final updatedState = state.copyWith(
          currentFlowM: () => result.currentFlowM,
        );

        emit(updatedState);

        if (result.shouldShowSuccessIndicator) {
          _overlayBloc.showSuccessIndicator();
        }

        _learningContentBloc.updateWith(
          collectionListItems: () => result.collectionListItems,
        );
    }
  }

  void requestLexicalItemExclusionFromLearning() {
    final result = _excludeLexicalItemFromLearning(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      paymentMechanism: _appInfoBloc.state!.paymentMechanism,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    switch (result) {
      case ActionNotPermittedLexicalItemExclusionFromLearningResult():
        _notificationStreamController.add(result.notification);

      case SucceededLexicalItemExclusionFromLearningResult():
        final updatedState = state.copyWith(
          currentFlowM: () => result.currentFlowM,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);

        if (result.shouldShowSuccessIndicator) {
          _overlayBloc.showSuccessIndicator();
        }

        _learningContentBloc.updateWith(
          lexicalItemMap: () => result.lexicalItemMap,
        );
    }
  }

  void requestCustomLexicalItemEditingDialogOpening() {
    final result = _openCustomLexicalItemEditingDialog(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
    );

    _notificationStreamController.add(result.notification);
  }

  void requestCustomLexicalItemUpdate({
    required CustomLexicalItem lexicalItem,
  }) {
    final result = _updateCustomLexicalItem(
      lexicalItem: lexicalItem,
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      lexicalItemMap: state.lexicalItemMap,
      availableEmailApps: _emailBloc.state!.availableEmailApps,
    );

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      lexicalItemMap: () => result.lexicalItemMap,
    );

    emit(updatedState);

    if (result.shouldShowSuccessIndicator) {
      _overlayBloc.showSuccessIndicator();
    }

    _learningContentBloc.updateWith(
      lexicalItemMap: () => result.lexicalItemMap,
    );
  }

  void requestLexicalItemDeletion({
    bool? lexicalItemDeletionConfirmed,
  }) {
    final collectionListItems = _learningContentBloc.state!.collectionListItems;
    final lexicalItemMap = state.lexicalItemMap;
    final collectionNavigatorPageModelToTransitionInfo =
        _collectionNavigatorBloc.state!.pageModelToTransitionInfo;

    final result = _deleteCustomLexicalItem(
      pageModel: _pageModel,
      lexicalItemDeletionConfirmed: lexicalItemDeletionConfirmed,
      lexicalItemId: _pageModel.lexicalItemId,
      collectionListItems: collectionListItems,
      lexicalItemMap: lexicalItemMap,
      collectionNavigatorPageModelToTransitionInfo: collectionNavigatorPageModelToTransitionInfo,
    );

    switch (result) {
      case DeletionConfirmationRequiredCustomLexicalItemDeletionResult():
        _notificationStreamController.add(result.notification);

      case SucceededCustomLexicalItemDeletionResult():
        final updatedState = state.copyWith(
          lexicalItemDeleted: () => result.lexicalItemDeleted,
          lexicalItemMap: () => result.lexicalItemMap,
        );

        emit(updatedState);

        if (result.shouldShowSuccessIndicator) {
          _overlayBloc.showSuccessIndicator();
        }

        _collectionNavigatorBloc.updateWith(
          pageModelToTransitionInfo: () => result.collectionNavigatorPageModelToTransitionInfo,
        );

        _learningContentBloc.updateWith(
          lexicalItemMap: () => result.lexicalItemMap,
          collectionListItems: () => result.collectionListItems,
        );
    }
  }

  void requestCardActionDialogOpening() {
    final result = _openCardActionDialog(
      currentFlowM: state.currentFlowM as MainCardContentExplorationFlowM,
    );

    _notificationStreamController.add(result.notification);
  }

  void requestAdditionalContentRevealing({
    required CardAdditionalContentRevealingMethod method,
  }) {
    final result = _revealAdditionalContent(
      method: method,
      lexicalItemId: _pageModel.lexicalItemId,
      lexicalItemMap: _learningContentBloc.state!.lexicalItemMap,
    );

    final updatedState = state.copyWith(
      nextFlowM: () => result.nextFlowM,
      flowTM: () => result.flowTM,
    );

    emit(updatedState);
  }

  void requestAdditionalContentClosing({
    required CardAdditionalContentClosingMethod method,
  }) {
    final dialect = _configurationBloc.state!.pronunciationConfiguration.dialect;
    final lexicalItemMap = _learningContentBloc.state!.lexicalItemMap;
    final collectionListItems = _learningContentBloc.state!.collectionListItems;
    final availableEmailApps = _emailBloc.state!.availableEmailApps;
    final unsafeToPronounceLexicalItemTitleMap =
        _learningContentBloc.state!.unsafeToPronounceLexicalItemTitleMap;
    final premiumAccessStatus = _userInfoBloc.state!.premiumAccessStatus;
    final imageEnablementEffective =
        _configurationBloc.state!.imageConfiguration.imageEnablementEffective;

    final result = _closeAdditionalContent(
      method: method,
      lexicalItemId: _pageModel.lexicalItemId,
      imageEnablementEffective: imageEnablementEffective,
      lexicalItemMap: lexicalItemMap,
      collectionListItems: collectionListItems,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
      premiumAccessStatus: premiumAccessStatus,
      dialect: dialect,
      availableEmailApps: availableEmailApps,
    );

    final updatedState = state.copyWith(
      nextFlowM: () => result.nextFlowM,
      flowTM: () => result.flowTM,
    );

    emit(updatedState);
  }

  void requestFlowChangeCompletion() {
    final result = _completeFlowChange(
      nextFlowM: state.nextFlowM!,
      flowTM: state.flowTM!,
    );

    final updatedState = state.copyWith(
      currentFlowM: () => result.currentFlowM,
      nextFlowM: () => result.nextFlowM,
      flowTM: () => result.flowTM,
    );

    emit(updatedState);
  }

  void requestFlowChangeCancellation() {
    final result = _cancelFlowChange();

    final updatedState = state.copyWith(
      nextFlowM: () => result.nextFlowM,
      flowTM: () => result.flowTM,
    );

    emit(updatedState);
  }

  @override
  Future<void> close() {
    _notificationStreamController.close();
    _cachedImagePathMapStreamSubscription.cancel();
    _learningContentBlocSubscription.cancel();
    _userInfoBlocSubscription.cancel();
    _emailBlocSubscription.cancel();
    _configurationBlocSubscription.cancel();
    return super.close();
  }
}
