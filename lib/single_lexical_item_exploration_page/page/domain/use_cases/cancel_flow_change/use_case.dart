import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_ms/flow_m.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/domain/entities/flow_tms/flow_tm.dart';

part 'result.dart';

abstract class CancelFlowChange {
  FlowChangeCancellationResult call();
}

class CancelFlowChangeImpl implements CancelFlowChange {
  const CancelFlowChangeImpl();

  @override
  FlowChangeCancellationResult call() {
    const result = FlowChangeCancellationResult(
      nextFlowM: null,
      flowTM: null,
    );

    return result;
  }
}
