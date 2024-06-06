import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/app_navigator_transition_info.dart';
import 'package:mobile_app.core/core/domain/entities/navigation/page_models/app_navigator_page_model.dart';
import 'package:mobile_app.core/core/domain/helpers/apply_navigator_page_push/use_case.dart';

part 'result.dart';

abstract interface class OpenSingleLexicalItemExplorationPage {
  SingleLexicalItemExplorationPageOpeningResult call({
    required String lexicalItemId,
    required BuiltList<AppNavigatorPageModel> collectionNavigatorPageModels,
    required BuiltMap<AppNavigatorPageModel, AppNavigatorTransitionInfo>
        collectionNavigatorPageModelToTransitionInfo,
  });
}

class OpenSingleLexicalItemExplorationPageImpl implements OpenSingleLexicalItemExplorationPage {
  const OpenSingleLexicalItemExplorationPageImpl({
    required ApplyNavigatorPagePush applyNavigatorPagePush,
  }) : _applyNavigatorPagePush = applyNavigatorPagePush;

  final ApplyNavigatorPagePush _applyNavigatorPagePush;

  @override
  SingleLexicalItemExplorationPageOpeningResult call({
    required String lexicalItemId,
    required BuiltList<AppNavigatorPageModel> collectionNavigatorPageModels,
    required BuiltMap<AppNavigatorPageModel, AppNavigatorTransitionInfo>
        collectionNavigatorPageModelToTransitionInfo,
  }) {
    final pageModel = SingleLexicalItemExplorationPageModel(
      lexicalItemId: lexicalItemId,
    );

    final pagePushResult = _applyNavigatorPagePush(
      pageModel: pageModel,
      pageModels: collectionNavigatorPageModels,
      pageModelToTransitionInfo: collectionNavigatorPageModelToTransitionInfo,
    );

    final result = SingleLexicalItemExplorationPageOpeningResult(
      collectionNavigatorPageModels: pagePushResult.pageModels,
      collectionNavigatorPageModelToTransitionInfo: pagePushResult.pageModelToTransitionInfo,
    );

    return result;
  }
}
