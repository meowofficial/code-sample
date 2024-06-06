import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/utils/uuid_generator.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/application/bloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/entities/additional_card_content_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/injection_container.dart'
    as additional_card_content_di;

part 'vloc_state.dart';

class AdditionalCardContentVloc extends Vloc<AdditionalCardContentVlocState> {
  AdditionalCardContentVloc({
    required BuiltList<LexicalItemUsageExample> usageExamples,
    required VoidCallback onAdditionalContentClosingRequested,
    required bool allowScrollingToBottom,
    required bool allowScrollingToTop,
  }) : _onAdditionalContentClosingRequested = onAdditionalContentClosingRequested {
    _bloc = AdditionalCardContentBloc(
      usageExamples: usageExamples,
      getInitialData: additional_card_content_di.sl(),
      closeAdditionalContent: additional_card_content_di.sl(),
      handleUsageExamplesOuterUpdate: additional_card_content_di.sl(),
      pronounceLexicalItemUsageExample: additional_card_content_di.sl(),
    );

    _bloc.stream.listen(_onBlocStateChanged);

    _bloc.notificationStream.listen(_onBlocNotificationReceived);

    final scrollViewKey = PageStorageKey(UuidGenerator().generateUuid());

    initialState = AdditionalCardContentVlocState(
      scrollViewKey: scrollViewKey,
      usageExamples: _bloc.state.usageExamples,
      allowScrollingToTop: allowScrollingToTop,
      allowScrollingToBottom: allowScrollingToBottom,
    );
  }

  final VoidCallback _onAdditionalContentClosingRequested;

  late final AdditionalCardContentBloc _bloc;

  @override
  late final AdditionalCardContentVlocState initialState;

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// outer update handlers
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  void updateUsageExamples({
    required BuiltList<LexicalItemUsageExample> usageExamples,
  }) {
    _bloc.requestUsageExamplesOuterUpdate(
      usageExamples: usageExamples,
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

  void onAdditionalContentButtonClosingPressed() {
    _bloc.requestAdditionalContentClosing();
  }

  void onUsageExamplePronunciationButtonPressed(LexicalItemUsageExample usageExample) {
    _bloc.requestUsageExamplePronunciation(
      usageExample: usageExample,
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /// notification handlers
  /////////////////////////////////////////////////////////////////////////////////////////////////
  // <editor-fold defaultstate="collapsed">

  void _handleAdditionalContentClosingNotification() {
    _onAdditionalContentClosingRequested();
  }

  // </editor-fold>

  void _onBlocNotificationReceived(AdditionalCardContentNotification notification) {
    switch (notification) {
      case AdditionalContentClosingNotification():
        _handleAdditionalContentClosingNotification();
    }
  }

  void _onBlocStateChanged(AdditionalCardContentBlocState blocState) {
    final updatedState = state.copyWith(
      usageExamples: () => blocState.usageExamples,
    );

    emit(updatedState);
  }

  @override
  void close() {
    _bloc.close();
    super.close();
  }
}
