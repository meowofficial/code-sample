import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/presentation/view/view.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/presentation/vloc/vloc.dart';

class AdditionalCardContent extends StatelessWidget {
  const AdditionalCardContent({
    required AdditionalCardContentVloc vloc,
    super.key,
  }) : _vloc = vloc;

  final AdditionalCardContentVloc _vloc;

  @override
  Widget build(BuildContext context) {
    return AdditionalCardContentView(
      vloc: _vloc,
    );
  }
}
