part of 'vloc.dart';

class SingleLexicalItemExplorationPageVlocState extends Equatable {
  const SingleLexicalItemExplorationPageVlocState({
    required this.currentFlowPM,
    required this.nextFlowPM,
    required this.flowTPM,
    required this.blockInteractions,
    required this.mainCardContentKey,
    required this.additionalCardContentKey,
    required this.customLexicalItemEditingDialogVloc,
  });

  final FlowPM currentFlowPM;
  final FlowPM? nextFlowPM;
  final FlowTPM? flowTPM;
  final bool blockInteractions;
  final GlobalKey mainCardContentKey;
  final GlobalKey additionalCardContentKey;
  final CustomLexicalItemEditingDialogVloc? customLexicalItemEditingDialogVloc;

  @override
  List<Object?> get props {
    return [
      currentFlowPM,
      nextFlowPM,
      flowTPM,
      blockInteractions,
      mainCardContentKey,
      additionalCardContentKey,
      customLexicalItemEditingDialogVloc,
    ];
  }

  SingleLexicalItemExplorationPageVlocState copyWith({
    FlowPM Function()? currentFlowPM,
    FlowPM? Function()? nextFlowPM,
    FlowTPM? Function()? flowTPM,
    bool Function()? blockInteractions,
    GlobalKey Function()? mainCardContentKey,
    GlobalKey Function()? additionalCardContentKey,
    CustomLexicalItemEditingDialogVloc? Function()? customLexicalItemEditingDialogVloc,
  }) {
    return SingleLexicalItemExplorationPageVlocState(
      currentFlowPM: currentFlowPM == null ? this.currentFlowPM : currentFlowPM(),
      nextFlowPM: nextFlowPM == null ? this.nextFlowPM : nextFlowPM(),
      flowTPM: flowTPM == null ? this.flowTPM : flowTPM(),
      blockInteractions: blockInteractions == null ? this.blockInteractions : blockInteractions(),
      mainCardContentKey:
          mainCardContentKey == null ? this.mainCardContentKey : mainCardContentKey(),
      additionalCardContentKey: additionalCardContentKey == null
          ? this.additionalCardContentKey
          : additionalCardContentKey(),
      customLexicalItemEditingDialogVloc: customLexicalItemEditingDialogVloc == null
          ? this.customLexicalItemEditingDialogVloc
          : customLexicalItemEditingDialogVloc(),
    );
  }
}
