import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';

part 'result.dart';

abstract class HandleDialectOuterUpdate {
  DialectOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required Dialect dialect,
    required bool lexicalItemDeleted,
  });
}

class HandleDialectOuterUpdateImpl implements HandleDialectOuterUpdate {
  const HandleDialectOuterUpdateImpl();

  @override
  DialectOuterUpdateHandlingResult? call({
    required FlowM currentFlowM,
    required FlowM? nextFlowM,
    required Dialect dialect,
    required bool lexicalItemDeleted,
  }) {
    if (lexicalItemDeleted) {
      return null;
    }

    switch (nextFlowM) {
      case null:
        switch (currentFlowM) {
          case AdditionalCardContentExplorationFlowM():
            final result = DialectOuterUpdateHandlingResult(
              currentFlowM: currentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;

          case MainCardContentExplorationFlowM():
            final updatedCurrentFlowM = currentFlowM.copyWith(
              dialect: () => dialect,
            );

            final result = DialectOuterUpdateHandlingResult(
              currentFlowM: updatedCurrentFlowM,
              nextFlowM: nextFlowM,
            );

            return result;
        }

      case AdditionalCardContentExplorationFlowM():
        final result = DialectOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: nextFlowM,
        );

        return result;

      case MainCardContentExplorationFlowM():
        final updatedNextFlowM = nextFlowM.copyWith(
          dialect: () => dialect,
        );

        final result = DialectOuterUpdateHandlingResult(
          currentFlowM: currentFlowM,
          nextFlowM: updatedNextFlowM,
        );

        return result;
    }
  }
}
