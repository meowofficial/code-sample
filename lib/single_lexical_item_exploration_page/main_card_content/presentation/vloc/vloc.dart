import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc.dart';
import 'package:mobile_app.core/dialogs/pronunciation_caution_dialog/presentation/dialog.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/application/bloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/entities/main_card_content_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/injection_container.dart'
    as main_card_content_di;

part 'vloc_state.dart';

class MainCardContentVloc extends Vloc<MainCardContentVlocState> {
  MainCardContentVloc({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required bool imageEnablementEffective,
    required BuiltMap<String, String> cachedImagePathMap,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required bool additionalContentPresent,
    required VoidCallback onCardActionDialogOpeningRequested,
    required VoidCallback onAdditionalContentRevealingRequested,
    required bool allowScrollingToBottom,
    required bool allowScrollingToTop,
  })  : _onCardActionDialogOpeningRequested = onCardActionDialogOpeningRequested,
        _onAdditionalContentRevealingRequested = onAdditionalContentRevealingRequested {
    _bloc = MainCardContentBloc(
      lexicalItem: lexicalItem,
      dialect: dialect,
      imageEnablementEffective: imageEnablementEffective,
      cachedImagePathMap: cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
      additionalContentPresent: additionalContentPresent,
      getInitialData: main_card_content_di.sl(),
      initialize: main_card_content_di.sl(),
      revealAdditionalContent: main_card_content_di.sl(),
      pronounceLexicalItem: main_card_content_di.sl(),
      handleAdditionalContentPresentOuterUpdate: main_card_content_di.sl(),
      handleDialectOuterUpdate: main_card_content_di.sl(),
      handleImageEnablementEffectiveOuterUpdate: main_card_content_di.sl(),
      handleCachedImagePathMapOuterUpdate: main_card_content_di.sl(),
      handleLexicalItemOuterUpdate: main_card_content_di.sl(),
      openCardActionDialog: main_card_content_di.sl(),
    );

    _bloc.stream.listen(_onBlocStateChanged);

    _bloc.notificationStream.listen(_onBlocNotificationReceived);

    initialState = MainCardContentVlocState(
      lexicalItem: _bloc.state.lexicalItem,
      imagePath: _bloc.state.imagePath,
      dialect: _bloc.state.dialect,
      safeToPronounce: _bloc.state.safeToPronounce,
      displayLexicalItemType: _bloc.state.displayLexicalItemType,
      additionalContentPresent: _bloc.state.additionalContentPresent,
      allowScrollingToTop: allowScrollingToTop,
      allowScrollingToBottom: allowScrollingToBottom,
    );
  }

  final VoidCallback _onCardActionDialogOpeningRequested;
  final VoidCallback _onAdditionalContentRevealingRequested;

  late final MainCardContentBloc _bloc;

  @override
  late final MainCardContentVlocState initialState;

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// outer update handlers
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  void updateDialect({
    required Dialect dialect,
  }) {
    _bloc.requestDialectOuterUpdateHandling(
      dialect: dialect,
    );
  }

  void updateImageEnablementEffective({
    required bool imageEnablementEffective,
  }) {
    _bloc.requestImageEnablementEffectiveOuterUpdateHandling(
      imageEnablementEffective: imageEnablementEffective,
    );
  }

  void updateAdditionalContentPresent({
    required bool additionalContentPresent,
  }) {
    _bloc.requestAdditionalContentPresentOuterUpdateHandling(
      additionalContentPresent: additionalContentPresent,
    );
  }

  void updateLexicalItem({
    required LexicalItem lexicalItem,
  }) {
    _bloc.requestLexicalItemOuterUpdateHandling(
      lexicalItem: lexicalItem,
    );
  }

  void updateCachedImagePathMap({
    required BuiltMap<String, String> cachedImagePathMap,
  }) {
    _bloc.requestCachedImagePathMapOuterUpdateHandling(
      cachedImagePathMap: cachedImagePathMap,
    );
  }

  void updateScrollAllowance({
    required bool allowScrollingToBottom,
    required bool allowScrollingToTop,
  }) {
    final updatedState = state.copyWith(
      allowScrollingToTop: () => allowScrollingToTop,
      allowScrollingToBottom: () => allowScrollingToBottom,
    );

    emit(updatedState);
  }

  // </editor-fold>

  void onPronunciationCautionButtonPressed() {
    showPronunciationCautionDialog();
  }

  void onLexicalItemPronunciationButtonPressed() {
    _bloc.requestLexicalItemPronunciation();
  }

  void onCardActionRevealingButtonPressed() {
    _bloc.requestCardActionDialogOpening();
  }

  void onCardAdditionalContentRevealingButtonPressed() {
    _bloc.requestAdditionalContentRevealing();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// notification handlers
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  void _handleAdditionalContentRevealingNotification() {
    _onAdditionalContentRevealingRequested();
  }

  void _handleCardActionDialogOpeningNotification() {
    _onCardActionDialogOpeningRequested();
  }

  // </editor-fold>

  void _onBlocNotificationReceived(MainCardContentNotification notification) {
    switch (notification) {
      case AdditionalContentRevealingNotification():
        _handleAdditionalContentRevealingNotification();

      case CardActionDialogOpeningNotification():
        _handleCardActionDialogOpeningNotification();
    }
  }

  void _onBlocStateChanged(MainCardContentBlocState blocState) {
    final updatedState = state.copyWith(
      lexicalItem: () => blocState.lexicalItem,
      imagePath: () => blocState.imagePath,
      dialect: () => blocState.dialect,
      safeToPronounce: () => blocState.safeToPronounce,
      displayLexicalItemType: () => blocState.displayLexicalItemType,
      additionalContentPresent: () => blocState.additionalContentPresent,
    );

    emit(updatedState);
  }

  @override
  void close() {
    _bloc.close();
    super.close();
  }
}
