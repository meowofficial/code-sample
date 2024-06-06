import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:mobile_app.core/core/domain/entities/card_additional_content_closing_method.dart';
import 'package:mobile_app.core/core/domain/entities/card_additional_content_revealing_method.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/page_models/app_navigator_page_model.dart';
import 'package:mobile_app.core/core/domain/entities/payment_mechanism.dart';
import 'package:mobile_app.core/core/presentation/navigator_keys.dart';
import 'package:mobile_app.core/core/presentation/themes/core_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc.dart';
import 'package:mobile_app.core/dialogs/addition_to_collection_card_action_dialog/presentation/dialog.dart';
import 'package:mobile_app.core/dialogs/custom_lexical_item_editing_dialog/dialog/presentation/dialog.dart';
import 'package:mobile_app.core/dialogs/custom_lexical_item_editing_dialog/dialog/presentation/vloc/vloc.dart';
import 'package:mobile_app.core/dialogs/email_app_selection_dialog/presentation/dialog.dart';
import 'package:mobile_app.core/dialogs/mistake_report_method_selection_card_action_dialog/presentation/dialog.dart';
import 'package:mobile_app.core/injection_container.dart' as core_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/presentation/vloc/vloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/dialogs/card_action_dialog/dialog.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/dialogs/orphan_custom_lexical_item_deletion_confirmation_dialog/dialog.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/dialogs/purchase_page_dialog/dialog.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/dialogs/used_custom_lexical_item_deletion_confirmation_dialog/dialog.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/presentation/vloc/vloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/application/bloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/deletion_card_action.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_tms/flow_tm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/single_lexical_item_page_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/injection_container.dart'
    as single_lexical_item_exploration_page_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/models/flow_pms/flow_pm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/models/flow_tpms/flow_tpm.dart';

part 'vloc_state.dart';

const _kScrollTransitionDistance = 200.0;

class SingleLexicalItemExplorationPageVloc extends Vloc<SingleLexicalItemExplorationPageVlocState> {
  SingleLexicalItemExplorationPageVloc({
    required SingleLexicalItemExplorationPageModel pageModel,
    required TickerProvider vsync,
  }) : _vsync = vsync {
    _bloc = SingleLexicalItemPageBloc(
      pageModel: pageModel,
      learningContentBloc: core_di.sl(),
      userInfoBloc: core_di.sl(),
      appInfoBloc: core_di.sl(),
      deviceInfoBloc: core_di.sl(),
      configurationBloc: core_di.sl(),
      overlayBloc: core_di.sl(),
      emailBloc: core_di.sl(),
      collectionNavigatorBloc: core_di.sl(),
      getInitialData: single_lexical_item_exploration_page_di.sl(),
      initialize: single_lexical_item_exploration_page_di.sl(),
      addLexicalItemToCustomCollection: single_lexical_item_exploration_page_di.sl(),
      addLexicalItemToLearningQueue: single_lexical_item_exploration_page_di.sl(),
      excludeLexicalItemFromLearning: single_lexical_item_exploration_page_di.sl(),
      handleAvailableEmailAppOuterUpdate: single_lexical_item_exploration_page_di.sl(),
      handleLearningContentOuterUpdate: single_lexical_item_exploration_page_di.sl(),
      handlePremiumAccessStatusOuterUpdate: single_lexical_item_exploration_page_di.sl(),
      markLexicalItemAsCompletelyLearned: single_lexical_item_exploration_page_di.sl(),
      markLexicalItemAsKnown: single_lexical_item_exploration_page_di.sl(),
      removeLexicalItemFromLearningQueue: single_lexical_item_exploration_page_di.sl(),
      reportLexicalItemMistakeByEmail: single_lexical_item_exploration_page_di.sl(),
      resetLexicalItemProgress: single_lexical_item_exploration_page_di.sl(),
      returnLexicalItemToLearning: single_lexical_item_exploration_page_di.sl(),
      handleCachedImagePathMapOuterUpdate: single_lexical_item_exploration_page_di.sl(),
      handleImageEnablementEffectiveOuterUpdate: single_lexical_item_exploration_page_di.sl(),
      handleDialectOuterUpdate: single_lexical_item_exploration_page_di.sl(),
      deleteCustomLexicalItem: single_lexical_item_exploration_page_di.sl(),
      reportLexicalItemMistake: single_lexical_item_exploration_page_di.sl(),
      reportLexicalItemMistakeThroughTelegram: single_lexical_item_exploration_page_di.sl(),
      openCardActionDialog: single_lexical_item_exploration_page_di.sl(),
      updateCustomLexicalItem: single_lexical_item_exploration_page_di.sl(),
      openCustomLexicalItemEditingDialog: single_lexical_item_exploration_page_di.sl(),
      revealAdditionalContent: single_lexical_item_exploration_page_di.sl(),
      completeFlowChange: single_lexical_item_exploration_page_di.sl(),
      closeAdditionalContent: single_lexical_item_exploration_page_di.sl(),
      cancelFlowChange: single_lexical_item_exploration_page_di.sl(),
    );

    _bloc.stream.listen(_onBlocStateChanged);

    _bloc.notificationStream.listen(_onBlocNotificationReceived);

    final blockInteractions = _shouldBlockInteractions(
      lexicalItemDeleted: _bloc.state.lexicalItemDeleted,
    );

    final blocCurrentFlowM = _bloc.state.currentFlowM;

    final FlowPM currentFlowPM;
    const flowTPM = null as FlowTPM?;

    switch (blocCurrentFlowM) {
      case AdditionalCardContentExplorationFlowM():
        final allowScrollingToTop = _isAdditionalCardContentScrollingToTopAllowed();

        final allowScrollingToBottom = _isAdditionalCardContentScrollingToBottomAllowed(
          flowTPM: flowTPM,
        );

        currentFlowPM = _createAdditionalCardContentExplorationFlowPM(
          blocFlowM: blocCurrentFlowM,
          allowScrollingToTop: allowScrollingToTop,
          allowScrollingToBottom: allowScrollingToBottom,
        );

      case MainCardContentExplorationFlowM():
        final allowScrollingToTop = _isMainCardContentScrollingToTopAllowed(
          flowTPM: flowTPM,
        );

        final allowScrollingToBottom = _isMainCardContentScrollingToBottomAllowed();

        currentFlowPM = _createMainCardContentExplorationFlowPM(
          blocFlowM: blocCurrentFlowM,
          allowScrollingToTop: allowScrollingToTop,
          allowScrollingToBottom: allowScrollingToBottom,
        );
    }

    initialState = SingleLexicalItemExplorationPageVlocState(
      currentFlowPM: currentFlowPM,
      nextFlowPM: null,
      flowTPM: flowTPM,
      blockInteractions: blockInteractions,
      additionalCardContentKey: GlobalKey(),
      mainCardContentKey: GlobalKey(),
      customLexicalItemEditingDialogVloc: null,
    );
  }

  final viewKey = GlobalKey();
  final TickerProvider _vsync;

  late final SingleLexicalItemPageBloc _bloc;

  @override
  late final SingleLexicalItemExplorationPageVlocState initialState;

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// scroll notification handlers
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  void onScrollStartNotificationReceived(ScrollStartNotification notification) {
    if (notification.depth != 0) {
      return;
    }

    if (state.flowTPM != null) {
      return;
    }

    switch (state.currentFlowPM) {
      case AdditionalCardContentExplorationFlowPM():
        _bloc.requestAdditionalContentClosing(
          method: CardAdditionalContentClosingMethod.scroll,
        );

      case MainCardContentExplorationFlowPM():
        _bloc.requestAdditionalContentRevealing(
          method: CardAdditionalContentRevealingMethod.scroll,
        );
    }
  }

  void onOverscrollNotificationReceived(OverscrollNotification notification) {
    if (notification.depth != 0) {
      return;
    }

    final flowTPM = state.flowTPM;

    switch (flowTPM) {
      case ScrollAdditionalToMainCardContentExplorationFlowTPM():
        if (flowTPM.released) {
          return;
        }

        flowTPM.animationController.value = (flowTPM.animationController.value -
                notification.overscroll / _kScrollTransitionDistance)
            .clamp(0.0, 1.0);

      case ScrollMainToAdditionalCardContentExplorationFlowTPM():
        if (flowTPM.released) {
          return;
        }

        flowTPM.animationController.value = (flowTPM.animationController.value +
                notification.overscroll / _kScrollTransitionDistance)
            .clamp(0.0, 1.0);

      case null:
      case ButtonTapAdditionalToMainCardContentExplorationFlowTPM():
      case ButtonTapMainToAdditionalCardContentExplorationFlowTPM():
        return;
    }
  }

  void onScrollEndNotificationReceived(ScrollEndNotification notification) {
    if (notification.depth != 0) {
      return;
    }

    final flowTPM = state.flowTPM;

    switch (flowTPM) {
      case ScrollAdditionalToMainCardContentExplorationFlowTPM():
        if (flowTPM.animationController.value == 1.0) {
          final updatedFlowTPM = flowTPM.copyWith(
            released: () => true,
          );

          final updatedState = state.copyWith(
            flowTPM: () => updatedFlowTPM,
          );

          emit(updatedState);

          _bloc.requestFlowChangeCompletion();

          return;
        }

        if (flowTPM.animationController.value == 0.0) {
          final updatedFlowTPM = flowTPM.copyWith(
            released: () => true,
          );

          final updatedState = state.copyWith(
            flowTPM: () => updatedFlowTPM,
          );

          emit(updatedState);

          _bloc.requestFlowChangeCancellation();

          return;
        }

        final velocity = notification.dragDetails?.primaryVelocity ?? 0.0;

        if (flowTPM.animationController.value + velocity * 0.5 / _kScrollTransitionDistance < 0.5) {
          final updatedAdditionalContentFadeOutAnimation = CurvedAnimation(
            curve: Interval(
              0.0,
              flowTPM.animationController.value,
              curve: Curves.easeOut,
            ),
            parent: flowTPM.animationController,
          ).drive(Tween<double>(
            begin: 1.0,
            end: flowTPM.additionalContentFadeOutAnimation.value,
          ));

          final updatedMainContentFadeInAnimation = CurvedAnimation(
            curve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeOut,
            ),
            parent: flowTPM.animationController,
          );

          flowTPM.animationController.reverse().whenComplete(_bloc.requestFlowChangeCancellation);

          final updatedFlowTPM = flowTPM.copyWith(
            additionalContentFadeOutAnimation: () => updatedAdditionalContentFadeOutAnimation,
            mainContentFadeInAnimation: () => updatedMainContentFadeInAnimation,
            released: () => true,
          );

          final updatedState = state.copyWith(
            flowTPM: () => updatedFlowTPM,
          );

          emit(updatedState);

          return;
        }

        final updatedAdditionalContentFadeOutAnimation = CurvedAnimation(
          curve: const Interval(
            0.0,
            0.5,
            curve: Curves.easeOut,
          ),
          parent: flowTPM.animationController,
        ).drive(Tween<double>(
          begin: 1.0,
          end: 0.0,
        ));

        final updatedMainContentFadeInAnimation = CurvedAnimation(
          curve: Interval(
            flowTPM.animationController.value,
            1.0,
            curve: Curves.easeOut,
          ),
          parent: flowTPM.animationController,
        ).drive(Tween<double>(
          begin: flowTPM.mainContentFadeInAnimation.value,
          end: 1.0,
        ));

        flowTPM.animationController.forward().whenComplete(_bloc.requestFlowChangeCompletion);

        final updatedFlowTPM = flowTPM.copyWith(
          additionalContentFadeOutAnimation: () => updatedAdditionalContentFadeOutAnimation,
          mainContentFadeInAnimation: () => updatedMainContentFadeInAnimation,
          released: () => true,
        );

        final updatedState = state.copyWith(
          flowTPM: () => updatedFlowTPM,
        );

        emit(updatedState);

      case ScrollMainToAdditionalCardContentExplorationFlowTPM():
        if (flowTPM.released) {
          return;
        }

        if (flowTPM.animationController.value == 1.0) {
          final updatedFlowTPM = flowTPM.copyWith(
            released: () => true,
          );

          final updatedState = state.copyWith(
            flowTPM: () => updatedFlowTPM,
          );

          emit(updatedState);

          _bloc.requestFlowChangeCompletion();

          return;
        }

        if (flowTPM.animationController.value == 0.0) {
          final updatedFlowTPM = flowTPM.copyWith(
            released: () => true,
          );

          final updatedState = state.copyWith(
            flowTPM: () => updatedFlowTPM,
          );

          emit(updatedState);

          _bloc.requestFlowChangeCancellation();

          return;
        }

        final velocity = notification.dragDetails?.primaryVelocity ?? 0.0;

        if (flowTPM.animationController.value - velocity * 0.5 / _kScrollTransitionDistance < 0.5) {
          final Animation<double> updatedMainContentFadeOutAnimation;

          if (flowTPM.animationController.value < 0.5) {
            updatedMainContentFadeOutAnimation = CurvedAnimation(
              curve: Interval(
                0.0,
                flowTPM.animationController.value,
                curve: Curves.easeOut,
              ),
              parent: flowTPM.animationController,
            ).drive(Tween<double>(
              begin: 1.0,
              end: flowTPM.mainContentFadeOutAnimation.value,
            ));
          } else {
            updatedMainContentFadeOutAnimation = CurvedAnimation(
              curve: const Interval(
                0.0,
                0.5,
                curve: Curves.easeOut,
              ),
              parent: flowTPM.animationController,
            ).drive(Tween<double>(
              begin: 1.0,
              end: 0.0,
            ));
          }

          final Animation<double> updatedAdditionalContentFadeInAnimation;

          if (flowTPM.animationController.value < 0.5) {
            updatedAdditionalContentFadeInAnimation = CurvedAnimation(
              curve: const Interval(
                0.5,
                1.0,
                curve: Curves.easeOut,
              ),
              parent: flowTPM.animationController,
            ).drive(Tween<double>(
              begin: 0.0,
              end: 1.0,
            ));
          } else {
            updatedAdditionalContentFadeInAnimation = CurvedAnimation(
              curve: Interval(
                0.5,
                flowTPM.animationController.value,
                curve: Curves.easeOut,
              ),
              parent: flowTPM.animationController,
            ).drive(Tween<double>(
              begin: 0.0,
              end: flowTPM.additionalContentFadeInAnimation.value,
            ));
          }

          flowTPM.animationController.reverse().whenComplete(_bloc.requestFlowChangeCancellation);

          final updatedFlowTPM = flowTPM.copyWith(
            mainContentFadeOutAnimation: () => updatedMainContentFadeOutAnimation,
            additionalContentFadeInAnimation: () => updatedAdditionalContentFadeInAnimation,
            released: () => true,
          );

          final updatedState = state.copyWith(
            flowTPM: () => updatedFlowTPM,
          );

          emit(updatedState);

          return;
        }

        final Animation<double> updatedMainContentFadeOutAnimation;

        if (flowTPM.animationController.value < 0.5) {
          updatedMainContentFadeOutAnimation = CurvedAnimation(
            curve: Interval(
              flowTPM.animationController.value,
              0.5,
              curve: Curves.easeOut,
            ),
            parent: flowTPM.animationController,
          ).drive(Tween<double>(
            begin: flowTPM.mainContentFadeOutAnimation.value,
            end: 0.0,
          ));
        } else {
          updatedMainContentFadeOutAnimation = CurvedAnimation(
            curve: const Interval(
              0.0,
              0.5,
              curve: Curves.easeOut,
            ),
            parent: flowTPM.animationController,
          ).drive(Tween<double>(
            begin: 1.0,
            end: 0.0,
          ));
        }

        final Animation<double> updatedAdditionalContentFadeInAnimation;

        if (flowTPM.animationController.value < 0.5) {
          updatedAdditionalContentFadeInAnimation = CurvedAnimation(
            curve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeOut,
            ),
            parent: flowTPM.animationController,
          );
        } else {
          updatedAdditionalContentFadeInAnimation = CurvedAnimation(
            curve: Interval(
              flowTPM.animationController.value,
              1.0,
              curve: Curves.easeOut,
            ),
            parent: flowTPM.animationController,
          ).drive(Tween<double>(
            begin: flowTPM.additionalContentFadeInAnimation.value,
            end: 1.0,
          ));
        }

        flowTPM.animationController.forward().whenComplete(_bloc.requestFlowChangeCompletion);

        final updatedFlowTPM = flowTPM.copyWith(
          mainContentFadeOutAnimation: () => updatedMainContentFadeOutAnimation,
          additionalContentFadeInAnimation: () => updatedAdditionalContentFadeInAnimation,
          released: () => true,
        );

        final updatedState = state.copyWith(
          flowTPM: () => updatedFlowTPM,
        );

        emit(updatedState);

      case null:
      case ButtonTapAdditionalToMainCardContentExplorationFlowTPM():
      case ButtonTapMainToAdditionalCardContentExplorationFlowTPM():
        return;
    }
  }

  // </editor-fold>

  bool _isMainCardContentScrollingToBottomAllowed() {
    return true;
  }

  bool _isMainCardContentScrollingToTopAllowed({
    required FlowTPM? flowTPM,
  }) {
    switch (flowTPM) {
      case ScrollMainToAdditionalCardContentExplorationFlowTPM():
        return flowTPM.animationController.value == 0.0;

      case null:
      case ButtonTapAdditionalToMainCardContentExplorationFlowTPM():
      case ButtonTapMainToAdditionalCardContentExplorationFlowTPM():
      case ScrollAdditionalToMainCardContentExplorationFlowTPM():
        return true;
    }
  }

  bool _isAdditionalCardContentScrollingToTopAllowed() {
    return true;
  }

  bool _isAdditionalCardContentScrollingToBottomAllowed({
    required FlowTPM? flowTPM,
  }) {
    switch (flowTPM) {
      case ScrollAdditionalToMainCardContentExplorationFlowTPM():
        return flowTPM.animationController.value == 0.0;

      case null:
      case ButtonTapAdditionalToMainCardContentExplorationFlowTPM():
      case ButtonTapMainToAdditionalCardContentExplorationFlowTPM():
      case ScrollMainToAdditionalCardContentExplorationFlowTPM():
        return true;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// FlowPM creation
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  AdditionalCardContentExplorationFlowPM _createAdditionalCardContentExplorationFlowPM({
    required AdditionalCardContentExplorationFlowM blocFlowM,
    required bool allowScrollingToTop,
    required bool allowScrollingToBottom,
  }) {
    final vloc = AdditionalCardContentVloc(
      usageExamples: blocFlowM.usageExamples,
      allowScrollingToTop: allowScrollingToTop,
      allowScrollingToBottom: allowScrollingToBottom,
      onAdditionalContentClosingRequested: () {
        _bloc.requestAdditionalContentClosing(
          method: CardAdditionalContentClosingMethod.buttonTap,
        );
      },
    );

    return AdditionalCardContentExplorationFlowPM(
      vloc: vloc,
    );
  }

  MainCardContentExplorationFlowPM _createMainCardContentExplorationFlowPM({
    required MainCardContentExplorationFlowM blocFlowM,
    required bool allowScrollingToTop,
    required bool allowScrollingToBottom,
  }) {
    final vloc = MainCardContentVloc(
      lexicalItem: blocFlowM.lexicalItem,
      dialect: blocFlowM.dialect,
      imageEnablementEffective: blocFlowM.imageEnablementEffective,
      cachedImagePathMap: blocFlowM.cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap: blocFlowM.unsafeToPronounceLexicalItemTitleMap,
      additionalContentPresent: blocFlowM.additionalContentPresent,
      allowScrollingToTop: allowScrollingToTop,
      allowScrollingToBottom: allowScrollingToBottom,
      onCardActionDialogOpeningRequested: _bloc.requestCardActionDialogOpening,
      onAdditionalContentRevealingRequested: () {
        _bloc.requestAdditionalContentRevealing(
          method: CardAdditionalContentRevealingMethod.buttonTap,
        );
      },
    );

    return MainCardContentExplorationFlowPM(
      vloc: vloc,
    );
  }

  // </editor-fold>

  void _disposeFlowPM({
    required FlowPM flowPM,
  }) {
    switch (flowPM) {
      case AdditionalCardContentExplorationFlowPM():
        flowPM.vloc.close();

      case MainCardContentExplorationFlowPM():
        flowPM.vloc.close();
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// FlowTPM creation
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  ButtonTapAdditionalToMainCardContentExplorationFlowTPM
      _createButtonTapAdditionalToMainCardContentExplorationFlowTPM() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: _vsync,
    );

    final additionalContentFadeOutAnimation = animationController
        .drive(CurveTween(
          curve: Curves.easeOut,
        ))
        .drive(Tween<double>(
          begin: 1.0,
          end: 0.0,
        ));

    final mainContentFadeInAnimation = animationController.drive(CurveTween(
      curve: Curves.easeOut,
    ));

    return ButtonTapAdditionalToMainCardContentExplorationFlowTPM(
      animationController: animationController,
      additionalContentFadeOutAnimation: additionalContentFadeOutAnimation,
      mainContentFadeInAnimation: mainContentFadeInAnimation,
    );
  }

  ButtonTapMainToAdditionalCardContentExplorationFlowTPM
      _createButtonTapMainToAdditionalCardContentExplorationFlowTPM() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: _vsync,
    );

    final mainContentFadeOutAnimation = animationController
        .drive(CurveTween(
          curve: Curves.easeOut,
        ))
        .drive(Tween<double>(
          begin: 1.0,
          end: 0.0,
        ));

    final additionalContentFadeInAnimation = animationController.drive(CurveTween(
      curve: Curves.easeOut,
    ));

    return ButtonTapMainToAdditionalCardContentExplorationFlowTPM(
      animationController: animationController,
      mainContentFadeOutAnimation: mainContentFadeOutAnimation,
      additionalContentFadeInAnimation: additionalContentFadeInAnimation,
    );
  }

  ScrollMainToAdditionalCardContentExplorationFlowTPM
      _createScrollMainToAdditionalCardContentExplorationFlowTPM() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: _vsync,
    );

    final mainContentFadeOutAnimation = CurvedAnimation(
      curve: const Interval(
        0.0,
        0.5,
      ),
      parent: animationController,
    ).drive(Tween<double>(
      begin: 1.0,
      end: 0.0,
    ));

    final additionalContentFadeInAnimation = CurvedAnimation(
      curve: const Interval(
        0.5,
        1.0,
      ),
      parent: animationController,
    );

    animationController.addListener(() {
      if (state.flowTPM is ScrollMainToAdditionalCardContentExplorationFlowTPM) {
        final currentFlowPM = state.currentFlowPM as MainCardContentExplorationFlowPM;

        final allowScrollingToTop = _isMainCardContentScrollingToTopAllowed(
          flowTPM: state.flowTPM,
        );

        final allowScrollingToBottom = _isMainCardContentScrollingToBottomAllowed();

        currentFlowPM.vloc.updateScrollAllowance(
          allowScrollingToBottom: allowScrollingToBottom,
          allowScrollingToTop: allowScrollingToTop,
        );
      }
    });

    return ScrollMainToAdditionalCardContentExplorationFlowTPM(
      animationController: animationController,
      mainContentFadeOutAnimation: mainContentFadeOutAnimation,
      additionalContentFadeInAnimation: additionalContentFadeInAnimation,
      released: false,
    );
  }

  ScrollAdditionalToMainCardContentExplorationFlowTPM
      _createScrollAdditionalToMainCardContentExplorationFlowTPM() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: _vsync,
    );

    final additionalContentFadeOutAnimation = CurvedAnimation(
      curve: const Interval(
        0.0,
        0.5,
      ),
      parent: animationController,
    ).drive(Tween<double>(
      begin: 1.0,
      end: 0.0,
    ));

    final mainContentFadeInAnimation = CurvedAnimation(
      curve: const Interval(
        0.5,
        1.0,
      ),
      parent: animationController,
    );

    animationController.addListener(() {
      if (state.flowTPM is ScrollAdditionalToMainCardContentExplorationFlowTPM) {
        final currentFlowPM = state.currentFlowPM as AdditionalCardContentExplorationFlowPM;

        final allowScrollingToTop = _isAdditionalCardContentScrollingToTopAllowed();

        final allowScrollingToBottom = _isAdditionalCardContentScrollingToBottomAllowed(
          flowTPM: state.flowTPM,
        );

        currentFlowPM.vloc.updateScrollAllowance(
          allowScrollingToBottom: allowScrollingToBottom,
          allowScrollingToTop: allowScrollingToTop,
        );
      }
    });

    return ScrollAdditionalToMainCardContentExplorationFlowTPM(
      animationController: animationController,
      additionalContentFadeOutAnimation: additionalContentFadeOutAnimation,
      mainContentFadeInAnimation: mainContentFadeInAnimation,
      released: false,
    );
  }

  // </editor-fold>

  void _disposeFlowTPM({
    required FlowTPM flowTPM,
  }) {
    switch (flowTPM) {
      case ButtonTapAdditionalToMainCardContentExplorationFlowTPM():
        flowTPM.animationController.dispose();

      case ButtonTapMainToAdditionalCardContentExplorationFlowTPM():
        flowTPM.animationController.dispose();

      case ScrollAdditionalToMainCardContentExplorationFlowTPM():
        flowTPM.animationController.dispose();

      case ScrollMainToAdditionalCardContentExplorationFlowTPM():
        flowTPM.animationController.dispose();
    }
  }

  void _schedule(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) => fn());
  }

  FlowPM _updateFlowPMFromBloc({
    required FlowPM flowPM,
    required FlowM blocFlowM,
  }) {
    switch (flowPM) {
      case AdditionalCardContentExplorationFlowPM():
        blocFlowM as AdditionalCardContentExplorationFlowM;

        final updatedFlowPM = flowPM;

        updatedFlowPM.vloc.updateUsageExamples(
          usageExamples: blocFlowM.usageExamples,
        );

        return updatedFlowPM;

      case MainCardContentExplorationFlowPM():
        blocFlowM as MainCardContentExplorationFlowM;

        final updatedFlowPM = flowPM;

        updatedFlowPM.vloc.updateCachedImagePathMap(
          cachedImagePathMap: blocFlowM.cachedImagePathMap,
        );

        updatedFlowPM.vloc.updateImageEnablementEffective(
          imageEnablementEffective: blocFlowM.imageEnablementEffective,
        );

        updatedFlowPM.vloc.updateAdditionalContentPresent(
          additionalContentPresent: blocFlowM.additionalContentPresent,
        );

        updatedFlowPM.vloc.updateDialect(
          dialect: blocFlowM.dialect,
        );

        updatedFlowPM.vloc.updateLexicalItem(
          lexicalItem: blocFlowM.lexicalItem,
        );

        return updatedFlowPM;
    }
  }

  bool _shouldBlockInteractions({
    required bool lexicalItemDeleted,
  }) {
    return lexicalItemDeleted;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// notification handlers
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  void _handlePurchasePageOpeningNotification({
    required PaymentMechanism paymentMechanism,
  }) {
    showPurchasePageDialog(
      paymentMechanism: paymentMechanism,
    );
  }

  void _handleUsedCustomLexicalItemDeletionConfirmationDialogOpeningNotification() async {
    final deletionConfirmed = await showUsedCustomLexicalItemDeletionConfirmationDialog();

    if (closed) {
      return;
    }

    if (deletionConfirmed == true) {
      _bloc.requestLexicalItemDeletion(
        lexicalItemDeletionConfirmed: true,
      );
    }
  }

  void _handleOrphanCustomLexicalItemDeletionConfirmationDialogOpeningNotification() async {
    final deletionConfirmed = await showOrphanCustomLexicalItemDeletionConfirmationDialog();

    if (closed) {
      return;
    }

    if (deletionConfirmed == true) {
      _bloc.requestLexicalItemDeletion(
        lexicalItemDeletionConfirmed: true,
      );
    }
  }

  void _handleEmailAppSelectionDialogOpeningNotification({
    required BuiltList<EmailApp> availableEmailApps,
  }) async {
    final selectedEmailApp = await showEmailAppSelectionDialog(
      availableEmailApps: availableEmailApps,
    );

    if (closed) {
      return;
    }

    if (selectedEmailApp != null) {
      _bloc.requestMistakeReportByEmail(
        selectedEmailApp: selectedEmailApp,
      );
    }
  }

  void _handleAdditionToCollectionDialogOpeningNotification({
    required BuiltList<AdditionToCustomCollectionCardActionCollectionInfo> collectionInfos,
  }) async {
    final selectedCustomCollectionId = await showAdditionToCollectionCardActionDialog(
      collectionInfos: collectionInfos,
    );

    if (closed) {
      return;
    }

    if (selectedCustomCollectionId != null) {
      _bloc.requestLexicalItemAdditionToCustomCollection(
        selectedCustomCollectionId: selectedCustomCollectionId,
      );
    }
  }

  void _handleCustomLexicalItemEditingDialogOpeningNotification({
    required CustomLexicalItem lexicalItem,
  }) async {
    final customLexicalItemEditingDialogVloc = CustomLexicalItemEditingDialogVloc(
      lexicalItem: lexicalItem,
      lexicalItemMap: _bloc.state.lexicalItemMap,
      vsync: _vsync,
      onCustomLexicalItemUpdated: (updatedLexicalItem) {
        Navigator.of(rootNavigatorKey.currentContext!).pop();

        if (closed) {
          return;
        }

        _bloc.requestCustomLexicalItemUpdate(
          lexicalItem: updatedLexicalItem,
        );
      },
      onCancelled: Navigator.of(rootNavigatorKey.currentContext!).pop,
    );

    var updatedState = state.copyWith(
      customLexicalItemEditingDialogVloc: () => customLexicalItemEditingDialogVloc,
    );

    emit(updatedState);

    await showCustomLexicalItemEditingDialog(
      vloc: customLexicalItemEditingDialogVloc,
    );

    customLexicalItemEditingDialogVloc.close();

    updatedState = state.copyWith(
      customLexicalItemEditingDialogVloc: () => null,
    );

    emit(updatedState);
  }

  void _handleMistakeReportMethodSelectionDialogOpeningNotification({
    required BuiltList<CardMistakeReportMethod> methods,
  }) async {
    final method = await showMistakeReportMethodSelectionCardActionDialog(
      methods: methods,
    );

    if (closed) {
      return;
    }

    switch (method) {
      case null:
        return;

      case CardMistakeReportThroughTelegramMethod():
        _bloc.requestMistakeReportThroughTelegram(
          primaryColorValue: CoreTheme.of(viewKey.currentContext!).primaryColor.value,
        );

      case CardMistakeReportByEmailMethod():
        _bloc.requestMistakeReportByEmail(
          selectedEmailApp: null,
        );
    }
  }

  void _handleCardActionDialogOpeningNotification({
    required BuiltList<CardAction> cardActions,
  }) async {
    final selectedCardAction = await showCardActionDialog(
      cardActions: cardActions,
    );

    if (closed) {
      return;
    }

    switch (selectedCardAction) {
      case MistakeReportCardAction():
        _bloc.requestMistakeReport();

      case ProgressResetCardAction():
        _bloc.requestProgressReset();

      case MarkAsKnownCardAction():
        _bloc.requestMarkLexicalItemAsKnown();

      case MarkAsCompletelyLearnedCardAction():
        _bloc.requestMarkLexicalItemAsCompletelyLearned();

      case AdditionToLearningQueueCardAction():
        _bloc.requestLexicalItemAdditionToLearningQueue();

      case RemovalFromLearningQueueCardAction():
        _bloc.requestLexicalItemRemovalFromLearningQueue();

      case ReturnToLearningCardAction():
        _bloc.requestLexicalItemReturnToLearning();

      case AdditionToCustomCollectionCardAction():
        _bloc.requestLexicalItemAdditionToCustomCollection();

      case EditingCardAction():
        _bloc.requestCustomLexicalItemEditingDialogOpening();

      case ExclusionFromLearningCardAction():
        _bloc.requestLexicalItemExclusionFromLearning();

      case DeletionCardAction():
        _bloc.requestLexicalItemDeletion();
    }
  }

  // </editor-fold>

  void _onBlocNotificationReceived(SingleLexicalItemPageNotification notification) {
    switch (notification) {
      case PurchasePageOpeningNotification():
        _handlePurchasePageOpeningNotification(
          paymentMechanism: notification.paymentMechanism,
        );

      case UsedCustomLexicalItemDeletionConfirmationDialogOpeningNotification():
        _handleUsedCustomLexicalItemDeletionConfirmationDialogOpeningNotification();

      case OrphanCustomLexicalItemDeletionConfirmationDialogOpeningNotification():
        _handleOrphanCustomLexicalItemDeletionConfirmationDialogOpeningNotification();

      case EmailAppSelectionDialogOpeningNotification():
        _handleEmailAppSelectionDialogOpeningNotification(
          availableEmailApps: notification.availableEmailApps,
        );

      case MistakeReportMethodSelectionDialogOpeningNotification():
        _handleMistakeReportMethodSelectionDialogOpeningNotification(
          methods: notification.methods,
        );

      case AdditionToCollectionDialogOpeningNotification():
        _handleAdditionToCollectionDialogOpeningNotification(
          collectionInfos: notification.collectionInfos,
        );

      case CustomLexicalItemEditingDialogOpeningNotification():
        _handleCustomLexicalItemEditingDialogOpeningNotification(
          lexicalItem: notification.lexicalItem,
        );

      case CardActionDialogOpeningNotification():
        _handleCardActionDialogOpeningNotification(
          cardActions: notification.cardActions,
        );
    }
  }

  void _onBlocStateChanged(SingleLexicalItemPageBlocState blocState) {
    final blocCurrentFlowM = blocState.currentFlowM;
    final blocNextFlowM = blocState.nextFlowM;
    final blocFlowTM = blocState.flowTM;

    final currentFlowPM = state.currentFlowPM;
    final nextFlowPM = state.nextFlowPM;
    final flowTPM = state.flowTPM;

    var updatedCurrentFlowPM = currentFlowPM;
    var updatedNextFlowPM = nextFlowPM;
    var updatedFlowTPM = flowTPM;

    if (blocCurrentFlowM is MainCardContentExplorationFlowM && blocNextFlowM == null) {
      if (currentFlowPM is MainCardContentExplorationFlowPM && nextFlowPM == null) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );
      } else if (currentFlowPM is AdditionalCardContentExplorationFlowPM &&
          nextFlowPM is MainCardContentExplorationFlowPM) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: nextFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        updatedNextFlowPM = null;
        updatedFlowTPM = null;

        _schedule(() {
          _disposeFlowPM(
            flowPM: currentFlowPM,
          );

          _disposeFlowTPM(
            flowTPM: flowTPM!,
          );
        });
      } else if (currentFlowPM is MainCardContentExplorationFlowPM &&
          nextFlowPM is AdditionalCardContentExplorationFlowPM) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        updatedNextFlowPM = null;
        updatedFlowTPM = null;

        _schedule(() {
          _disposeFlowPM(
            flowPM: nextFlowPM,
          );

          _disposeFlowTPM(
            flowTPM: flowTPM!,
          );
        });
      } else if (currentFlowPM is AdditionalCardContentExplorationFlowPM && nextFlowPM == null) {
        updatedFlowTPM = null;

        final allowScrollingToTop = _isMainCardContentScrollingToTopAllowed(
          flowTPM: updatedFlowTPM,
        );

        final allowScrollingToBottom = _isMainCardContentScrollingToBottomAllowed();

        updatedCurrentFlowPM = _createMainCardContentExplorationFlowPM(
          blocFlowM: blocCurrentFlowM,
          allowScrollingToTop: allowScrollingToTop,
          allowScrollingToBottom: allowScrollingToBottom,
        );

        updatedNextFlowPM = null;

        _schedule(() {
          _disposeFlowPM(
            flowPM: currentFlowPM,
          );
        });
      } else if (currentFlowPM is MainCardContentExplorationFlowPM &&
          nextFlowPM is AdditionalCardContentExplorationFlowPM) {
        updatedFlowTPM = null;

        final allowScrollingToTop = _isMainCardContentScrollingToTopAllowed(
          flowTPM: updatedFlowTPM,
        );

        final allowScrollingToBottom = _isMainCardContentScrollingToBottomAllowed();

        updatedCurrentFlowPM = _createMainCardContentExplorationFlowPM(
          blocFlowM: blocCurrentFlowM,
          allowScrollingToTop: allowScrollingToTop,
          allowScrollingToBottom: allowScrollingToBottom,
        );

        updatedNextFlowPM = null;

        _schedule(() {
          _disposeFlowPM(
            flowPM: currentFlowPM,
          );

          _disposeFlowPM(
            flowPM: nextFlowPM,
          );

          _disposeFlowTPM(
            flowTPM: flowTPM!,
          );
        });
      }
    } else if (blocCurrentFlowM is AdditionalCardContentExplorationFlowM && blocNextFlowM == null) {
      if (currentFlowPM is AdditionalCardContentExplorationFlowPM && nextFlowPM == null) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );
      } else if (currentFlowPM is MainCardContentExplorationFlowPM &&
          nextFlowPM is AdditionalCardContentExplorationFlowPM) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: nextFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        updatedNextFlowPM = null;
        updatedFlowTPM = null;

        _schedule(() {
          _disposeFlowPM(
            flowPM: currentFlowPM,
          );

          _disposeFlowTPM(
            flowTPM: flowTPM!,
          );
        });
      } else if (currentFlowPM is AdditionalCardContentExplorationFlowPM &&
          nextFlowPM is MainCardContentExplorationFlowPM) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        updatedNextFlowPM = null;
        updatedFlowTPM = null;

        _schedule(() {
          _disposeFlowPM(
            flowPM: nextFlowPM,
          );

          _disposeFlowTPM(
            flowTPM: flowTPM!,
          );
        });
      }
    } else if (blocCurrentFlowM is MainCardContentExplorationFlowM &&
        blocNextFlowM is AdditionalCardContentExplorationFlowM) {
      blocFlowTM as MainToAdditionalCardContentExplorationFlowTM;

      if (currentFlowPM is MainCardContentExplorationFlowPM &&
          nextFlowPM is AdditionalCardContentExplorationFlowPM) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        updatedNextFlowPM = _updateFlowPMFromBloc(
          flowPM: nextFlowPM,
          blocFlowM: blocNextFlowM,
        );
      } else if (currentFlowPM is MainCardContentExplorationFlowPM && nextFlowPM == null) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        switch (blocFlowTM.method) {
          case CardAdditionalContentRevealingMethod.buttonTap:
            final _updatedFlowTPM = _createButtonTapMainToAdditionalCardContentExplorationFlowTPM();

            _updatedFlowTPM.animationController
                .forward(from: 0.0)
                .whenComplete(_bloc.requestFlowChangeCompletion);

            updatedFlowTPM = _updatedFlowTPM;

          case CardAdditionalContentRevealingMethod.scroll:
            updatedFlowTPM = _createScrollMainToAdditionalCardContentExplorationFlowTPM();
        }

        final allowScrollingToTop = _isAdditionalCardContentScrollingToTopAllowed();

        final allowScrollingToBottom = _isAdditionalCardContentScrollingToBottomAllowed(
          flowTPM: updatedFlowTPM,
        );

        updatedNextFlowPM = _createAdditionalCardContentExplorationFlowPM(
          blocFlowM: blocNextFlowM,
          allowScrollingToTop: allowScrollingToTop,
          allowScrollingToBottom: allowScrollingToBottom,
        );
      }
    } else if (blocCurrentFlowM is AdditionalCardContentExplorationFlowM &&
        blocNextFlowM is MainCardContentExplorationFlowM) {
      blocFlowTM as AdditionalToMainCardContentExplorationFlowTM;

      if (currentFlowPM is AdditionalCardContentExplorationFlowPM &&
          nextFlowPM is MainCardContentExplorationFlowPM) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        updatedNextFlowPM = _updateFlowPMFromBloc(
          flowPM: nextFlowPM,
          blocFlowM: blocNextFlowM,
        );
      } else if (currentFlowPM is AdditionalCardContentExplorationFlowPM && nextFlowPM == null) {
        updatedCurrentFlowPM = _updateFlowPMFromBloc(
          flowPM: currentFlowPM,
          blocFlowM: blocCurrentFlowM,
        );

        switch (blocFlowTM.method) {
          case CardAdditionalContentClosingMethod.buttonTap:
            final _updatedFlowTPM = _createButtonTapAdditionalToMainCardContentExplorationFlowTPM();

            _updatedFlowTPM.animationController
                .forward(from: 0.0)
                .whenComplete(_bloc.requestFlowChangeCompletion);

            updatedFlowTPM = _updatedFlowTPM;

          case CardAdditionalContentClosingMethod.scroll:
            updatedFlowTPM = _createScrollAdditionalToMainCardContentExplorationFlowTPM();
        }

        final allowScrollingToTop = _isMainCardContentScrollingToTopAllowed(
          flowTPM: updatedFlowTPM,
        );

        final allowScrollingToBottom = _isMainCardContentScrollingToBottomAllowed();

        updatedNextFlowPM = _createMainCardContentExplorationFlowPM(
          blocFlowM: blocNextFlowM,
          allowScrollingToTop: allowScrollingToTop,
          allowScrollingToBottom: allowScrollingToBottom,
        );
      }
    }

    final blockInteractions = _shouldBlockInteractions(
      lexicalItemDeleted: blocState.lexicalItemDeleted,
    );

    final updatedState = state.copyWith(
      currentFlowPM: () => updatedCurrentFlowPM,
      nextFlowPM: () => updatedNextFlowPM,
      flowTPM: () => updatedFlowTPM,
      blockInteractions: () => blockInteractions,
    );

    updatedState.customLexicalItemEditingDialogVloc?.updateLexicalItemMap(
      lexicalItemMap: blocState.lexicalItemMap,
    );

    emit(updatedState);
  }

  @override
  void close() {
    _bloc.close();

    _disposeFlowPM(
      flowPM: state.currentFlowPM,
    );

    if (state.nextFlowPM != null) {
      _disposeFlowPM(
        flowPM: state.nextFlowPM!,
      );
    }

    if (state.flowTPM != null) {
      _disposeFlowTPM(
        flowTPM: state.flowTPM!,
      );
    }

    state.customLexicalItemEditingDialogVloc?.close();

    super.close();
  }
}
