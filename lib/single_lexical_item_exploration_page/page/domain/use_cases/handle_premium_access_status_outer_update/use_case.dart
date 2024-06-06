import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';

part 'result.dart';

abstract class HandlePremiumAccessStatusOuterUpdate {
  PremiumAccessStatusOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required BuiltList<EmailApp> availableEmailApps,
    required bool lexicalItemDeleted,
  });
}

class HandlePremiumAccessStatusOuterUpdateImpl implements HandlePremiumAccessStatusOuterUpdate {
  const HandlePremiumAccessStatusOuterUpdateImpl({
    required GetCardActions getCardActions,
  }) : _getCardActions = getCardActions;

  final GetCardActions _getCardActions;

  @override
  PremiumAccessStatusOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required PremiumAccessStatus premiumAccessStatus,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required BuiltList<EmailApp> availableEmailApps,
    required bool lexicalItemDeleted,
  }) {
    if (lexicalItemDeleted) {
      return null;
    }

    switch (nextFlowM) {
      case null:
        switch (currentFlowM) {
          case AdditionalCardContentExplorationFlowM():
            final result = PremiumAccessStatusOuterUpdateHandlingResult(
              currentFlowM: currentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;

          case MainCardContentExplorationFlowM():
            final updatedCardActions = _getCardActions(
              lexicalItem: currentFlowM.lexicalItem,
              lexicalItemMap: lexicalItemMap,
              collectionListItems: collectionListItems,
              premiumAccessStatus: premiumAccessStatus,
              availableEmailApps: availableEmailApps,
            );

            final updatedCurrentFlowM = currentFlowM.copyWith(
              cardActions: () => updatedCardActions,
            );

            final result = PremiumAccessStatusOuterUpdateHandlingResult(
              currentFlowM: updatedCurrentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;
        }

      case AdditionalCardContentExplorationFlowM():
        final result = PremiumAccessStatusOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: nextFlowM,
        );

        return result;

      case MainCardContentExplorationFlowM():
        final updatedCardActions = _getCardActions(
          lexicalItem: nextFlowM.lexicalItem,
          lexicalItemMap: lexicalItemMap,
          collectionListItems: collectionListItems,
          premiumAccessStatus: premiumAccessStatus,
          availableEmailApps: availableEmailApps,
        );

        final updatedNextFlowM = nextFlowM.copyWith(
          cardActions: () => updatedCardActions,
        );

        final result = PremiumAccessStatusOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: updatedNextFlowM,
        );

        return result;
    }
  }
}
