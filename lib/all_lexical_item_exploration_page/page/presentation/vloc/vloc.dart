import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc.dart';
import 'package:mobile_app.core/injection_container.dart' as core_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/application/bloc.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/injection_container.dart'
    as all_lexical_item_exploration_page_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/models/lexical_item_pm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/models/lexical_item_progress_pms/lexical_item_progress_pm.dart';

part 'vloc_state.dart';

class AllLexicalItemExplorationPageVloc extends Vloc<AllLexicalItemExplorationPageVlocState> {
  AllLexicalItemExplorationPageVloc() {
    _bloc = AllLexicalItemExplorationPageBloc(
      learningContentBloc: core_di.sl(),
      userInfoBloc: core_di.sl(),
      collectionNavigatorBloc: core_di.sl(),
      getInitialData: all_lexical_item_exploration_page_di.sl(),
      changeSearchBarInputText: all_lexical_item_exploration_page_di.sl(),
      handleLearningContentOuterUpdate: all_lexical_item_exploration_page_di.sl(),
      handlePremiumAccessStatusOuterUpdate: all_lexical_item_exploration_page_di.sl(),
      openSingleLexicalItemExplorationPage: all_lexical_item_exploration_page_di.sl(),
      initialize: all_lexical_item_exploration_page_di.sl(),
    );

    _bloc.stream.listen(_onBlocStateChanged);

    final filteredLexicalItemModels = _createFilteredLexicalItemPMs(
      filteredLexicalItems: _bloc.state.filteredLexicalItems,
      lexicalItemProgressPercentMap: _bloc.state.lexicalItemProgressPercentMap,
      permittedLexicalItemIds: _bloc.state.permittedLexicalItemIds,
      searchByTitle: _bloc.state.searchByTitle,
    );

    final searchBarTextEditingController = TextEditingController(
      text: _bloc.state.searchBarInputText,
    );

    final searchBarFocusNode = FocusNode();

    initialState = AllLexicalItemExplorationPageVlocState(
      filteredLexicalItemPMs: filteredLexicalItemModels,
      searchBarTextEditingController: searchBarTextEditingController,
      searchBarFocusNode: searchBarFocusNode,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchBarFocusNode.requestFocus();
    });
  }

  final viewKey = GlobalKey();

  late final AllLexicalItemExplorationPageBloc _bloc;

  @override
  late final AllLexicalItemExplorationPageVlocState initialState;

  void onSearchBarTextChanged() {
    _bloc.requestSearchBarInputTextChange(
      searchBarInputText: state.searchBarTextEditingController.text,
    );
  }

  bool onLexicalItemTilesScrolled(ScrollUpdateNotification scrollNotification) {
    if (scrollNotification.dragDetails != null && state.searchBarFocusNode.hasFocus) {
      FocusScope.of(viewKey.currentContext!).unfocus();
    }

    return true;
  }

  void onLexicalItemTilePressed({
    required String lexicalItemId,
  }) {
    _bloc.requestSingleLexicalItemPageOpening(
      lexicalItemId: lexicalItemId,
    );
  }

  void _ensureTextEditingControllerTextMatches({
    required TextEditingController textEditingController,
    required String text,
  }) {
    if (textEditingController.text != text) {
      textEditingController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
      );
    }
  }

  LexicalItemProgressPM _createLexicalItemProgressPM({
    required LexicalItem lexicalItem,
    required int progressPercent,
  }) {
    if (lexicalItem.excluded) {
      return const ExcludedLexicalItemProgressPM();
    }

    final progress = lexicalItem.progress;

    switch (progress) {
      case null:
        return const UnspecifiedLexicalItemProgressPM();

      case PreviouslyKnownLexicalItemProgress():
        return const PreviouslyKnownLexicalItemProgressPM();

      case LearningLexicalItemProgress():
        if (progressPercent == 100) {
          return const CompletelyLearnedLexicalItemProgressPM();
        }

        return LearningLexicalItemProgressPM(
          progressPercent: progressPercent,
        );
    }
  }

  BuiltList<LexicalItemPM> _createFilteredLexicalItemPMs({
    required BuiltList<LexicalItem> filteredLexicalItems,
    required BuiltMap<String, int> lexicalItemProgressPercentMap,
    required BuiltSet<String> permittedLexicalItemIds,
    required bool searchByTitle,
  }) {
    return filteredLexicalItems.map((lexicalItem) {
      final progressPM = _createLexicalItemProgressPM(
        lexicalItem: lexicalItem,
        progressPercent: lexicalItemProgressPercentMap[lexicalItem.id]!,
      );

      final title = searchByTitle ? lexicalItem.title : lexicalItem.translation;

      final translation = searchByTitle ? lexicalItem.translation : lexicalItem.title;

      final permitted = permittedLexicalItemIds.contains(lexicalItem.id);

      return LexicalItemPM(
        id: lexicalItem.id,
        title: title,
        translation: translation,
        progressPM: progressPM,
        permitted: permitted,
      );
    }).toBuiltList();
  }

  void _onBlocStateChanged(AllLexicalItemExplorationPageBlocState blocState) {
    final filteredLexicalItemModels = _createFilteredLexicalItemPMs(
      filteredLexicalItems: blocState.filteredLexicalItems,
      lexicalItemProgressPercentMap: blocState.lexicalItemProgressPercentMap,
      permittedLexicalItemIds: blocState.permittedLexicalItemIds,
      searchByTitle: blocState.searchByTitle,
    );

    final updatedState = state.copyWith(
      filteredLexicalItemPMs: () => filteredLexicalItemModels,
    );

    _ensureTextEditingControllerTextMatches(
      textEditingController: updatedState.searchBarTextEditingController,
      text: blocState.searchBarInputText,
    );

    emit(updatedState);
  }

  @override
  void close() {
    state.searchBarTextEditingController.dispose();
    state.searchBarFocusNode.dispose();

    _bloc.close();

    super.close();
  }
}
