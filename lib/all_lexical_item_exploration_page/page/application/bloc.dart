import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/application/collection_navigator_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/learning_content_bloc/bloc.dart';
import 'package:mobile_app.core/core/application/user_info_bloc/bloc.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/change_search_bar_input_text/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/get_initial_data/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/handle_learning_content_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/handle_premium_access_status_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/initialize/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/open_single_lexical_item_exploration_page/use_case.dart';

part 'bloc_state.dart';

class AllLexicalItemExplorationPageBloc extends Cubit<AllLexicalItemExplorationPageBlocState> {
  AllLexicalItemExplorationPageBloc({
    required LearningContentBloc learningContentBloc,
    required UserInfoBloc userInfoBloc,
    required CollectionNavigatorBloc collectionNavigatorBloc,
    required Initialize initialize,
    required GetInitialData getInitialData,
    required ChangeSearchBarInputText changeSearchBarInputText,
    required HandleLearningContentOuterUpdate handleLearningContentOuterUpdate,
    required HandlePremiumAccessStatusOuterUpdate handlePremiumAccessStatusOuterUpdate,
    required OpenSingleLexicalItemExplorationPage openSingleLexicalItemExplorationPage,
  })  : _learningContentBloc = learningContentBloc,
        _userInfoBloc = userInfoBloc,
        _collectionNavigatorBloc = collectionNavigatorBloc,
        _changeSearchBarInputText = changeSearchBarInputText,
        _handleLearningContentOuterUpdate = handleLearningContentOuterUpdate,
        _handlePremiumAccessStatusOuterUpdate = handlePremiumAccessStatusOuterUpdate,
        _openSingleLexicalItemExplorationPage = openSingleLexicalItemExplorationPage,
        super(_getInitialState(
          learningContentBlocState: learningContentBloc.state!,
          userInfoBlocState: userInfoBloc.state!,
          getInitialData: getInitialData,
        )) {
    initialize();

    _learningContentBlocSubscription =
        learningContentBloc.streamWithPrevious.listen(_onLearningContentBlocStateChanged);

    _userInfoBlocSubscription = userInfoBloc.streamWithPrevious.listen(_onUserInfoBlocStateChanged);
  }

  final LearningContentBloc _learningContentBloc;
  final UserInfoBloc _userInfoBloc;
  final CollectionNavigatorBloc _collectionNavigatorBloc;

  final ChangeSearchBarInputText _changeSearchBarInputText;
  final HandleLearningContentOuterUpdate _handleLearningContentOuterUpdate;
  final HandlePremiumAccessStatusOuterUpdate _handlePremiumAccessStatusOuterUpdate;
  final OpenSingleLexicalItemExplorationPage _openSingleLexicalItemExplorationPage;

  late final StreamSubscription<(LearningContentBlocState, LearningContentBlocState?)>
      _learningContentBlocSubscription;
  late final StreamSubscription<(UserInfoBlocState, UserInfoBlocState?)> _userInfoBlocSubscription;

  static AllLexicalItemExplorationPageBlocState _getInitialState({
    required LearningContentBlocState learningContentBlocState,
    required UserInfoBlocState userInfoBlocState,
    required GetInitialData getInitialData,
  }) {
    final result = getInitialData(
      lexicalItemMap: learningContentBlocState.lexicalItemMap,
      collectionListItems: learningContentBlocState.collectionListItems,
      premiumAccessStatus: userInfoBlocState.premiumAccessStatus,
    );

    return AllLexicalItemExplorationPageBlocState(
      filteredLexicalItems: result.filteredLexicalItems,
      lexicalItemProgressPercentMap: result.lexicalItemProgressPercentMap,
      permittedLexicalItemIds: result.permittedLexicalItemIds,
      searchBarInputText: result.searchBarInputText,
      searchByTitle: result.searchByTitle,
    );
  }

  void _onLearningContentBlocStateChanged(
      (LearningContentBlocState, LearningContentBlocState?) valueWithPrevious) {
    final (learningContentBlocState, learningContentBlocPreviousState!) = valueWithPrevious;

    if (identical(learningContentBlocState.lexicalItemMap,
            learningContentBlocPreviousState.lexicalItemMap) &&
        identical(learningContentBlocState.collectionListItems,
            learningContentBlocPreviousState.collectionListItems)) {
      return;
    }

    final result = _handleLearningContentOuterUpdate(
      lexicalItemMap: learningContentBlocState.lexicalItemMap,
      collectionListItems: learningContentBlocState.collectionListItems,
      premiumAccessStatus: _userInfoBloc.state!.premiumAccessStatus,
      searchBarInputText: state.searchBarInputText,
    );

    final updatedState = state.copyWith(
      filteredLexicalItems: () => result.filteredLexicalItems,
      lexicalItemProgressPercentMap: () => result.lexicalItemProgressPercentMap,
      permittedLexicalItemIds: () => result.permittedLexicalItemIds,
    );

    emit(updatedState);
  }

  void _onUserInfoBlocStateChanged((UserInfoBlocState, UserInfoBlocState?) valueWithPrevious) {
    final (userInfoBlocState, userInfoBlocPreviousState) = valueWithPrevious;

    if (userInfoBlocState.premiumAccessStatus == userInfoBlocPreviousState!.premiumAccessStatus) {
      return;
    }

    final result = _handlePremiumAccessStatusOuterUpdate(
      lexicalItemMap: _learningContentBloc.state!.lexicalItemMap,
      collectionListItems: _learningContentBloc.state!.collectionListItems,
      premiumAccessStatus: userInfoBlocState.premiumAccessStatus,
    );

    final updatedState = state.copyWith(
      permittedLexicalItemIds: () => result.permittedLexicalItemIds,
    );

    emit(updatedState);
  }

  void requestSearchBarInputTextChange({
    required String searchBarInputText,
  }) {
    final result = _changeSearchBarInputText(
      searchBarInputText: searchBarInputText,
      lexicalItemMap: _learningContentBloc.state!.lexicalItemMap,
    );

    final updatedState = state.copyWith(
      filteredLexicalItems: () => result.filteredLexicalItems,
      searchBarInputText: () => result.searchBarInputText,
      searchByTitle: () => result.searchByTitle,
    );

    emit(updatedState);
  }

  void requestSingleLexicalItemPageOpening({
    required String lexicalItemId,
  }) {
    final collectionNavigatorPageModels = _collectionNavigatorBloc.state!.pageModels;

    final collectionNavigatorPageModelToTransitionInfo =
        _collectionNavigatorBloc.state!.pageModelToTransitionInfo;

    final result = _openSingleLexicalItemExplorationPage(
      lexicalItemId: lexicalItemId,
      collectionNavigatorPageModels: collectionNavigatorPageModels,
      collectionNavigatorPageModelToTransitionInfo: collectionNavigatorPageModelToTransitionInfo,
    );

    _collectionNavigatorBloc.updateWith(
      pageModels: () => result.collectionNavigatorPageModels,
      pageModelToTransitionInfo: () => result.collectionNavigatorPageModelToTransitionInfo,
    );
  }

  @override
  Future<void> close() {
    _learningContentBlocSubscription.cancel();
    _userInfoBlocSubscription.cancel();
    return super.close();
  }
}
