import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/card_additional_content_closing_method.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/collection_list_item/collection_list_item.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/premium_access_status.dart';
import 'package:mobile_app.core/core/domain/services/image_service/service.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_tms/flow_tm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/get_card_actions/helper.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/helpers/is_additional_content_present/helper.dart';

part 'result.dart';

abstract class CloseAdditionalContent {
  AdditionalContentClosingResult call({
    required CardAdditionalContentClosingMethod method,
    required String lexicalItemId,
    required bool imageEnablementEffective,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required Dialect dialect,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required BuiltList<EmailApp> availableEmailApps,
  });
}

class CloseAdditionalContentImpl implements CloseAdditionalContent {
  const CloseAdditionalContentImpl({
    required GetCardActions getCardActions,
    required IsAdditionalContentPresent isAdditionalContentPresent,
    required ImageService imageService,
  })  : _getCardActions = getCardActions,
        _isAdditionalContentPresent = isAdditionalContentPresent,
        _imageService = imageService;

  final GetCardActions _getCardActions;
  final IsAdditionalContentPresent _isAdditionalContentPresent;

  final ImageService _imageService;

  @override
  AdditionalContentClosingResult call({
    required CardAdditionalContentClosingMethod method,
    required String lexicalItemId,
    required bool imageEnablementEffective,
    required BuiltMap<String, LexicalItem> lexicalItemMap,
    required BuiltList<CollectionListItem> collectionListItems,
    required PremiumAccessStatus premiumAccessStatus,
    required Dialect dialect,
    required BuiltMap<Dialect, BuiltSet<String>> unsafeToPronounceLexicalItemTitleMap,
    required BuiltList<EmailApp> availableEmailApps,
  }) {
    final lexicalItem = lexicalItemMap[lexicalItemId]!;

    final cardActions = _getCardActions(
      lexicalItem: lexicalItem,
      lexicalItemMap: lexicalItemMap,
      collectionListItems: collectionListItems,
      premiumAccessStatus: premiumAccessStatus,
      availableEmailApps: availableEmailApps,
    );

    final additionalContentPresent = _isAdditionalContentPresent(
      lexicalItem: lexicalItem,
    );

    final nextFlowM = MainCardContentExplorationFlowM(
      lexicalItem: lexicalItem,
      dialect: dialect,
      additionalContentPresent: additionalContentPresent,
      imageEnablementEffective: imageEnablementEffective,
      cachedImagePathMap: _imageService.cachedImagePathMap,
      unsafeToPronounceLexicalItemTitleMap: unsafeToPronounceLexicalItemTitleMap,
      cardActions: cardActions,
    );

    final flowTM = AdditionalToMainCardContentExplorationFlowTM(
      method: method,
    );

    final result = AdditionalContentClosingResult(
      nextFlowM: nextFlowM,
      flowTM: flowTM,
    );

    return result;
  }
}
