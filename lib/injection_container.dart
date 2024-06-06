import 'package:get_it/get_it.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/injection_container.dart'
    as all_lexical_item_exploration_page_di;
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/injection_container.dart'
    as single_lexical_item_exploration_page_di;

final sl = GetIt.asNewInstance();

Future<void> init() async {
  await Future.wait([
    all_lexical_item_exploration_page_di.init(),
    single_lexical_item_exploration_page_di.init(),
  ]);
}
