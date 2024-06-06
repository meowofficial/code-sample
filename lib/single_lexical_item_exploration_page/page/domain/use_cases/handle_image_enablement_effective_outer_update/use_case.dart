import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';

part 'result.dart';

abstract class HandleImageEnablementEffectiveOuterUpdate {
  ImageEnablementEffectiveOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required bool imageEnablementEffective,
    required bool lexicalItemDeleted,
  });
}

class HandleImageEnablementEffectiveOuterUpdateImpl
    implements HandleImageEnablementEffectiveOuterUpdate {
  const HandleImageEnablementEffectiveOuterUpdateImpl();

  @override
  ImageEnablementEffectiveOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required bool imageEnablementEffective,
    required bool lexicalItemDeleted,
  }) {
    if (lexicalItemDeleted) {
      return null;
    }

    switch (nextFlowM) {
      case null:
        switch (currentFlowM) {
          case AdditionalCardContentExplorationFlowM():
            final result = ImageEnablementEffectiveOuterUpdateHandlingResult(
              currentFlowM: currentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;

          case MainCardContentExplorationFlowM():
            final updatedCurrentFlowM = currentFlowM.copyWith(
              imageEnablementEffective: () => imageEnablementEffective,
            );

            final result = ImageEnablementEffectiveOuterUpdateHandlingResult(
              currentFlowM: updatedCurrentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;
        }

      case AdditionalCardContentExplorationFlowM():
        final result = ImageEnablementEffectiveOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: nextFlowM,
        );

        return result;

      case MainCardContentExplorationFlowM():
        final updatedNextFlowM = nextFlowM.copyWith(
          imageEnablementEffective: () => imageEnablementEffective,
        );

        final result = ImageEnablementEffectiveOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: updatedNextFlowM,
        );

        return result;
    }
  }
}
