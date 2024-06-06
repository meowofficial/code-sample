import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/entities/additional_card_content_notifications.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/get_initial_data/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/close_additional_content/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/handle_usage_examples_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/pronounce_lexical_item_usage_example/use_case.dart';

part 'bloc_state.dart';

class AdditionalCardContentBloc extends Cubit<AdditionalCardContentBlocState> {
  AdditionalCardContentBloc({
    required BuiltList<LexicalItemUsageExample> usageExamples,
    required GetInitialData getInitialData,
    required CloseAdditionalContent closeAdditionalContent,
    required HandleUsageExamplesOuterUpdate handleUsageExamplesOuterUpdate,
    required PronounceLexicalItemUsageExample pronounceLexicalItemUsageExample,
  })  : _closeAdditionalContent = closeAdditionalContent,
        _handleUsageExamplesOuterUpdate = handleUsageExamplesOuterUpdate,
        _pronounceLexicalItemUsageExample = pronounceLexicalItemUsageExample,
        super(_getInitialState(
          usageExamples: usageExamples,
          getInitialData: getInitialData,
        ));

  static AdditionalCardContentBlocState _getInitialState({
    required BuiltList<LexicalItemUsageExample> usageExamples,
    required GetInitialData getInitialData,
  }) {
    final result = getInitialData(
      usageExamples: usageExamples,
    );

    return AdditionalCardContentBlocState(
      usageExamples: result.usageExamples,
      flowCompleted: result.flowCompleted,
    );
  }

  final CloseAdditionalContent _closeAdditionalContent;
  final HandleUsageExamplesOuterUpdate _handleUsageExamplesOuterUpdate;
  final PronounceLexicalItemUsageExample _pronounceLexicalItemUsageExample;

  final _notificationStreamController =
      StreamController<AdditionalCardContentNotification>.broadcast();

  Stream<AdditionalCardContentNotification> get notificationStream =>
      _notificationStreamController.stream;

  void requestUsageExamplesOuterUpdate({
    required BuiltList<LexicalItemUsageExample> usageExamples,
  }) {
    final result = _handleUsageExamplesOuterUpdate(
      usageExamples: usageExamples,
      flowCompleted: state.flowCompleted,
    );

    if (result != null) {
      final updatedState = state.copyWith(
        usageExamples: () => result.usageExamples,
      );

      emit(updatedState);
    }
  }

  void requestUsageExamplePronunciation({
    required LexicalItemUsageExample usageExample,
  }) {
    _pronounceLexicalItemUsageExample(
      usageExample: usageExample,
    );
  }

  void requestAdditionalContentClosing() {
    final result = _closeAdditionalContent(
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
