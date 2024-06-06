part of 'use_case.dart';

class SingleLexicalItemExplorationPageOpeningResult extends Equatable {
  const SingleLexicalItemExplorationPageOpeningResult({
    required this.collectionNavigatorPageModels,
    required this.collectionNavigatorPageModelToTransitionInfo,
  });

  final BuiltList<AppNavigatorPageModel> collectionNavigatorPageModels;
  final BuiltMap<AppNavigatorPageModel, AppNavigatorTransitionInfo>
      collectionNavigatorPageModelToTransitionInfo;

  @override
  List<Object?> get props {
    return [
      collectionNavigatorPageModels,
      collectionNavigatorPageModelToTransitionInfo,
    ];
  }
}
