import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';

part 'result.dart';

abstract class HandleCachedImagePathMapOuterUpdate {
  CachedImagePathMapOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required BuiltMap<String, String> cachedImagePathMap,
    required bool lexicalItemDeleted,
  });
}

class HandleCachedImagePathMapOuterUpdateImpl implements HandleCachedImagePathMapOuterUpdate {
  const HandleCachedImagePathMapOuterUpdateImpl();

  @override
  CachedImagePathMapOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required BuiltMap<String, String> cachedImagePathMap,
    required bool lexicalItemDeleted,
  }) {
    if (lexicalItemDeleted) {
      return null;
    }

    switch (nextFlowM) {
      case null:
        switch (currentFlowM) {
          case AdditionalCardContentExplorationFlowM():
            final result = CachedImagePathMapOuterUpdateHandlingResult(
              currentFlowM: currentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;

          case MainCardContentExplorationFlowM():
            final updatedCurrentFlowM = currentFlowM.copyWith(
              cachedImagePathMap: () => cachedImagePathMap,
            );

            final result = CachedImagePathMapOuterUpdateHandlingResult(
              currentFlowM: updatedCurrentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;
        }

      case AdditionalCardContentExplorationFlowM():
        final result = CachedImagePathMapOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: nextFlowM,
        );

        return result;

      case MainCardContentExplorationFlowM():
        final updatedNextFlowM = nextFlowM.copyWith(
          cachedImagePathMap: () => cachedImagePathMap,
        );

        final result = CachedImagePathMapOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: updatedNextFlowM,
        );

        return result;
    }
  }
}
