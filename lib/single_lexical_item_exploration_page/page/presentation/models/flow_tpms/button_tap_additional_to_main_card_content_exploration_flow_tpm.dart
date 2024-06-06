part of 'flow_tpm.dart';

class ButtonTapAdditionalToMainCardContentExplorationFlowTPM extends Equatable implements FlowTPM {
  const ButtonTapAdditionalToMainCardContentExplorationFlowTPM({
    required this.animationController,
    required this.additionalContentFadeOutAnimation,
    required this.mainContentFadeInAnimation,
  });

  final AnimationController animationController;
  final Animation<double> additionalContentFadeOutAnimation;
  final Animation<double> mainContentFadeInAnimation;

  @override
  List<Object?> get props {
    return [
      animationController,
      additionalContentFadeOutAnimation,
      mainContentFadeInAnimation,
    ];
  }

  ButtonTapAdditionalToMainCardContentExplorationFlowTPM copyWith({
    AnimationController Function()? animationController,
    Animation<double> Function()? additionalContentFadeOutAnimation,
    Animation<double> Function()? mainContentFadeInAnimation,
  }) {
    return ButtonTapAdditionalToMainCardContentExplorationFlowTPM(
      animationController:
          animationController == null ? this.animationController : animationController(),
      additionalContentFadeOutAnimation: additionalContentFadeOutAnimation == null
          ? this.additionalContentFadeOutAnimation
          : additionalContentFadeOutAnimation(),
      mainContentFadeInAnimation: mainContentFadeInAnimation == null
          ? this.mainContentFadeInAnimation
          : mainContentFadeInAnimation(),
    );
  }
}
