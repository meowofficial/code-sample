import 'package:get_it/get_it.dart';
import 'package:mobile_app.core/injection_container.dart' as core_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/close_additional_content/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/get_initial_data/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/handle_usage_examples_outer_update/use_case.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/domain/use_cases/pronounce_lexical_item_usage_example/use_case.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  // use cases

  sl.registerLazySingleton<CloseAdditionalContent>(() {
    return const CloseAdditionalContentImpl();
  });

  sl.registerLazySingleton<GetInitialData>(() {
    return const GetInitialDataImpl();
  });

  sl.registerLazySingleton<HandleUsageExamplesOuterUpdate>(() {
    return const HandleUsageExamplesOuterUpdateImpl();
  });

  sl.registerLazySingleton<PronounceLexicalItemUsageExample>(() {
    return PronounceLexicalItemUsageExampleImpl(
      ttsService: core_di.sl(),
      getLexicalItemUsageExampleTitle: core_di.sl(),
    );
  });
}
