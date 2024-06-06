import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/page_models/app_navigator_page_model.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/view/view.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/vloc/vloc.dart';

class AllLexicalItemExplorationPage extends StatefulWidget {
  const AllLexicalItemExplorationPage({
    required this.pageModel,
    super.key,
  });

  final AllLexicalItemExplorationPageModel pageModel;

  @override
  State<AllLexicalItemExplorationPage> createState() => _AllLexicalItemExplorationPageState();
}

class _AllLexicalItemExplorationPageState extends State<AllLexicalItemExplorationPage>
    with TickerProviderStateMixin {
  late final AllLexicalItemExplorationPageVloc _vloc;

  @override
  void initState() {
    super.initState();
    _vloc = AllLexicalItemExplorationPageVloc();
  }

  @override
  void dispose() {
    _vloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AllLexicalItemExplorationPageView(
      key: _vloc.viewKey,
      vloc: _vloc,
    );
  }
}
