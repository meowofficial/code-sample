import 'package:get_it/get_it.dart';
import 'package:mobile_app.core/injection_container.dart' as core_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/domain/helpers/should_display_lexical_item_type/helper.dart';
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

final sl = GetIt.asNewInstance();

Future<void> init() async {
  // domain helpers

  sl.registerLazySingleton<ShouldDisplayLexicalItemType>(() {
    return const ShouldDisplayLexicalItemTypeImpl();
  });

  // use cases

  sl.registerLazySingleton<GetInitialData>(() {
    return GetInitialDataImpl(
      getLexicalItemEffectiveImagePath: core_di.sl(),
      isLexicalItemSafeToPronounce: core_di.sl(),
      shouldDisplayLexicalItemType: sl(),
    );
  });

  sl.registerLazySingleton<HandleCachedImagePathMapOuterUpdate>(() {
    return HandleCachedImagePathMapOuterUpdateImpl(
      getLexicalItemEffectiveImagePath: core_di.sl(),
    );
  });

  sl.registerLazySingleton<HandleAdditionalContentPresentOuterUpdate>(() {
    return const HandleAdditionalContentPresentOuterUpdateImpl();
  });

  sl.registerLazySingleton<HandleDialectOuterUpdate>(() {
    return HandleDialectOuterUpdateImpl(
      isLexicalItemSafeToPronounce: core_di.sl(),
    );
  });

  sl.registerLazySingleton<HandleImageEnablementEffectiveOuterUpdate>(() {
    return HandleImageEnablementEffectiveOuterUpdateImpl(
      getLexicalItemEffectiveImagePath: core_di.sl(),
    );
  });

  sl.registerLazySingleton<HandleLexicalItemOuterUpdate>(() {
    return HandleLexicalItemOuterUpdateImpl(
      getLexicalItemEffectiveImagePath: core_di.sl(),
      isLexicalItemSafeToPronounce: core_di.sl(),
      shouldDisplayLexicalItemType: sl(),
    );
  });

  sl.registerLazySingleton<Initialize>(() {
    return InitializeImpl(
      maybeStartLexicalItemImageDownload: core_di.sl(),
    );
  });

  sl.registerLazySingleton<OpenCardActionDialog>(() {
    return const OpenCardActionDialogImpl();
  });

  sl.registerLazySingleton<PronounceLexicalItem>(() {
    return PronounceLexicalItemImpl(
      ttsService: core_di.sl(),
    );
  });

  sl.registerLazySingleton<RevealAdditionalContent>(() {
    return const RevealAdditionalContentImpl();
  });
}
