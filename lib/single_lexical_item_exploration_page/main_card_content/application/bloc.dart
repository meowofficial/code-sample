import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/entities/main_card_content_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/get_initial_data/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/handle_additional_content_present_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/handle_cached_image_path_map_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/handle_dialect_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/handle_image_enablement_effective_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/handle_lexical_item_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/initialize/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/open_card_action_dialog/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/pronounce_lexical_item/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/use_cases/reveal_additional_content/use_case.dart';

part 'bloc_state.dart';

class MainCardContentBloc extends Cubit<MainCardContentBlocState> {
  MainCardContentBloc({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required bool imageEnablementEffective,
    required BuiltMap<String, String> cachedImagePathMap,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required bool additionalContentPresent,
    required GetInitialData getInitialData,
    required Initialize initialize,
    required HandleAdditionalContentPresentOuterUpdate handleAdditionalContentPresentOuterUpdate,
    required HandleCachedImagePathMapOuterUpdate handleCachedImagePathMapOuterUpdate,
    required HandleDialectOuterUpdate handleDialectOuterUpdate,
    required HandleImageEnablementEffectiveOuterUpdate handleImageEnablementEffectiveOuterUpdate,
    required HandleLexicalItemOuterUpdate handleLexicalItemOuterUpdate,
    required OpenCardActionDialog openCardActionDialog,
    required PronounceLexicalItem pronounceLexicalItem,
    required RevealAdditionalContent revealAdditionalContent,
  })  : _handleAdditionalContentPresentOuterUpdate = handleAdditionalContentPresentOuterUpdate,
        _handleCachedImagePathMapOuterUpdate = handleCachedImagePathMapOuterUpdate,
        _handleDialectOuterUpdate = handleDialectOuterUpdate,
        _handleImageEnablementEffectiveOuterUpdate = handleImageEnablementEffectiveOuterUpdate,
        _handleLexicalItemOuterUpdate = handleLexicalItemOuterUpdate,
        _openCardActionDialog = openCardActionDialog,
        _pronounceLexicalItem = pronounceLexicalItem,
        _revealAdditionalContent = revealAdditionalContent,
        super(_getInitialState(
          lexicalItem: lexicalItem,
          dialect: dialect,
          imageEnablementEffective: imageEnablementEffective,
          cachedImagePathMap: cachedImagePathMap,
          unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
          additionalContentPresent: additionalContentPresent,
          getInitialData: getInitialData,
        )) {
    initialize(
      lexicalItem: state.lexicalItem,
    );
  }

  final HandleAdditionalContentPresentOuterUpdate _handleAdditionalContentPresentOuterUpdate;
  final HandleCachedImagePathMapOuterUpdate _handleCachedImagePathMapOuterUpdate;
  final HandleDialectOuterUpdate _handleDialectOuterUpdate;
  final HandleImageEnablementEffectiveOuterUpdate _handleImageEnablementEffectiveOuterUpdate;
  final HandleLexicalItemOuterUpdate _handleLexicalItemOuterUpdate;
  final OpenCardActionDialog _openCardActionDialog;
  final PronounceLexicalItem _pronounceLexicalItem;
  final RevealAdditionalContent _revealAdditionalContent;

  final _notificationStreamController = StreamController<MainCardContentNotification>.broadcast();

  Stream<MainCardContentNotification> get notificationStream =>
      _notificationStreamController.stream;

  static MainCardContentBlocState _getInitialState({
    required LexicalItem lexicalItem,
    required Dialect dialect,
    required bool imageEnablementEffective,
    required BuiltMap<String, String> cachedImagePathMap,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required bool additionalContentPresent,
    required GetInitialData getInitialData,
  }) {
    final result = getInitialData(
      lexicalItem: lexicalItem,
      imageEnablementEffective: imageEnablementEffective,
      cachedImagePathMap: cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
      dialect: dialect,
      additionalContentPresent: additionalContentPresent,
    );

    return MainCardContentBlocState(
      lexicalItem: result.lexicalItem,
      dialect: result.dialect,
      imageEnablementEffective: result.imageEnablementEffective,
      cachedImagePathMap: result.cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap: result.unsafeToPronounceLexicalItemTitleMap,
      imagePath: result.imagePath,
      safeToPronounce: result.safeToPronounce,
      displayLexicalItemType: result.displayLexicalItemType,
      additionalContentPresent: result.additionalContentPresent,
      flowCompleted: result.flowCompleted,
    );
  }

  void requestCachedImagePathMapOuterUpdateHandling({
    required BuiltMap<String, String> cachedImagePathMap,
  }) {
    final result = _handleCachedImagePathMapOuterUpdate(
      lexicalItem: state.lexicalItem,
      imageEnablementEffective: state.imageEnablementEffective,
      cachedImagePathMap: cachedImagePathMap,
    );

    final updatedState = state.copyWith(
      imagePath: () => result.imagePath,
      cachedImagePathMap: () => result.cachedImagePathMap,
    );

    emit(updatedState);
  }

  void requestDialectOuterUpdateHandling({
    required Dialect dialect,
  }) {
    final result = _handleDialectOuterUpdate(
      lexicalItem: state.lexicalItem,
      dialect: dialect,
      unsafeToPronounceLexicalItemTitleMap: state.unsafeToPronounceLexicalItemTitleMap,
    );

    final updatedState = state.copyWith(
      dialect: () => result.dialect,
      safeToPronounce: () => result.safeToPronounce,
    );

    emit(updatedState);
  }

  void requestImageEnablementEffectiveOuterUpdateHandling({
    required bool imageEnablementEffective,
  }) {
    final result = _handleImageEnablementEffectiveOuterUpdate(
      lexicalItem: state.lexicalItem,
      cachedImagePathMap: state.cachedImagePathMap,
      imageEnablementEffective: imageEnablementEffective,
    );

    final updatedState = state.copyWith(
      imagePath: () => result.imagePath,
      imageEnablementEffective: () => result.imageEnablementEffective,
    );

    emit(updatedState);
  }

  void requestAdditionalContentPresentOuterUpdateHandling({
    required bool additionalContentPresent,
  }) {
    final result = _handleAdditionalContentPresentOuterUpdate(
      additionalContentPresent: additionalContentPresent,
    );

    final updatedState = state.copyWith(
      additionalContentPresent: () => result.additionalContentPresent,
    );

    emit(updatedState);
  }

  void requestLexicalItemOuterUpdateHandling({
    required LexicalItem lexicalItem,
  }) {
    final result = _handleLexicalItemOuterUpdate(
      lexicalItem: state.lexicalItem,
      cachedImagePathMap: state.cachedImagePathMap,
      imageEnablementEffective: state.imageEnablementEffective,
      unsafeToPronounceLexicalItemTitleMap: state.unsafeToPronounceLexicalItemTitleMap,
      dialect: state.dialect,
    );

    final updatedState = state.copyWith(
      lexicalItem: () => result.lexicalItem,
      imagePath: () => result.imagePath,
      safeToPronounce: () => result.safeToPronounce,
      displayLexicalItemType: () => result.displayLexicalItemType,
    );

    emit(updatedState);
  }

  void requestLexicalItemPronunciation() {
    _pronounceLexicalItem(
      lexicalItemTitle: state.lexicalItem.title,
    );
  }

  void requestCardActionDialogOpening() {
    final result = _openCardActionDialog();

    _notificationStreamController.add(result.notification);
  }

  void requestAdditionalContentRevealing() {
    final result = _revealAdditionalContent(
      flowCompleted: state.flowCompleted,
    );

    if (result != null) {
      final updatedState = state.copyWith(
        flowCompleted: () => result.flowCompleted,
      );

      emit(updatedState);

      _notificationStreamController.add(result.notification);
    }
  }

  @override
  Future<void> close() {
    _notificationStreamController.close();
    return super.close();
  }
}
