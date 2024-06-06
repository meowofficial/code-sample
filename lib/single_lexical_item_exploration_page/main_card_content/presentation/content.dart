import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/presentation/view/view.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/presentation/vloc/vloc.dart';

class MainCardContent extends StatelessWidget {
  const MainCardContent({
    required MainCardContentVloc vloc,
    super.key,
  }) : _vloc = vloc;

  final MainCardContentVloc _vloc;

  @override
  Widget build(BuildContext context) {
    return MainCardContentView(
      vloc: _vloc,
    );
  }
}
