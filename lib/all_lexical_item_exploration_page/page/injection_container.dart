import 'package:get_it/get_it.dart';
import 'package:mobile_app.core/injection_container.dart' as core_di;
import 'package:mobile_app.home.collections.core/core/injection_container.dart'
    as collection_core_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/helpers/get_filtered_lexical_item_sorting/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/change_search_bar_input_text/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/get_initial_data/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/handle_learning_content_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/handle_premium_access_status_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/initialize/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/domain/use_cases/open_single_lexical_item_exploration_page/use_case.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  // domain helpers

  sl.registerLazySingleton<GetFilteredLexicalItemSorting>(() {
    return const GetFilteredLexicalItemSortingImpl();
  });

  // use cases

  sl.registerLazySingleton<ChangeSearchBarInputText>(() {
    return ChangeSearchBarInputTextImpl(
      sortLexicalItems: core_di.sl(),
      filterLexicalItemsByPrefix: collection_core_di.sl(),
      isLexicalItemTitlePrefix: collection_core_di.sl(),
      getFilteredLexicalItemSorting: sl(),
    );
  });

  sl.registerLazySingleton<GetInitialData>(() {
    return GetInitialDataImpl(
      sortLexicalItems: core_di.sl(),
      isLexicalItemTitlePrefix: collection_core_di.sl(),
      getLexicalItemProgressPercentMap: core_di.sl(),
      getPermittedCollectionListItemIds: core_di.sl(),
      getPermittedLexicalItemIds: core_di.sl(),
      getFilteredLexicalItemSorting: sl(),
      filterLexicalItemsByPrefix: collection_core_di.sl(),
    );
  });

  sl.registerLazySingleton<HandleLearningContentOuterUpdate>(() {
    return HandleLearningContentOuterUpdateImpl(
      sortLexicalItems: core_di.sl(),
      filterLexicalItemsByPrefix: collection_core_di.sl(),
      isLexicalItemTitlePrefix: collection_core_di.sl(),
      getLexicalItemProgressPercentMap: core_di.sl(),
      getPermittedCollectionListItemIds: core_di.sl(),
      getPermittedLexicalItemIds: core_di.sl(),
      getFilteredLexicalItemSorting: sl(),
    );
  });

  sl.registerLazySingleton<HandlePremiumAccessStatusOuterUpdate>(() {
    return HandlePremiumAccessStatusOuterUpdateImpl(
      getPermittedCollectionListItemIds: core_di.sl(),
      getPermittedLexicalItemIds: core_di.sl(),
    );
  });

  sl.registerLazySingleton<Initialize>(() {
    return InitializeImpl(
      amplitudeAnalyticsService: core_di.sl(),
      mixpanelAnalyticsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<OpenSingleLexicalItemExplorationPage>(() {
    return OpenSingleLexicalItemExplorationPageImpl(
      applyNavigatorPagePush: core_di.sl(),
    );
  });
}
