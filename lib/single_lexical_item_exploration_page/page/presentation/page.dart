import 'package:flutter/cupertino.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/page_models/app_navigator_page_model.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/view/view.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/vloc/vloc.dart';

class SingleLexicalItemExplorationPage extends StatefulWidget {
  const SingleLexicalItemExplorationPage({
    required this.pageModel,
    super.key,
  });

  final SingleLexicalItemExplorationPageModel pageModel;

  @override
  State<SingleLexicalItemExplorationPage> createState() => _SingleLexicalItemExplorationPageState();
}

class _SingleLexicalItemExplorationPageState extends State<SingleLexicalItemExplorationPage>
    with TickerProviderStateMixin {
  late final SingleLexicalItemExplorationPageVloc _vloc;

  @override
  void initState() {
    super.initState();

    _vloc = SingleLexicalItemExplorationPageVloc(
      pageModel: widget.pageModel,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _vloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleLexicalItemExplorationPageView(
      key: _vloc.viewKey,
      vloc: _vloc,
    );
  }
}
