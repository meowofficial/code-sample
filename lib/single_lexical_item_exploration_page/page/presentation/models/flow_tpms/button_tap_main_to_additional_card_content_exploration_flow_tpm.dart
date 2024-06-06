part of 'flow_tpm.dart';

class ButtonTapMainToAdditionalCardContentExplorationFlowTPM extends Equatable implements FlowTPM {
  const ButtonTapMainToAdditionalCardContentExplorationFlowTPM({
    required this.animationController,
    required this.mainContentFadeOutAnimation,
    required this.additionalContentFadeInAnimation,
  });

  final AnimationController animationController;
  final Animation<double> mainContentFadeOutAnimation;
  final Animation<double> additionalContentFadeInAnimation;

  @override
  List<Object?> get props {
    return [
      animationController,
      mainContentFadeOutAnimation,
      additionalContentFadeInAnimation,
    ];
  }

  ButtonTapMainToAdditionalCardContentExplorationFlowTPM copyWith({
    AnimationController Function()? animationController,
    Animation<double> Function()? mainContentFadeOutAnimation,
    Animation<double> Function()? additionalContentFadeInAnimation,
  }) {
    return ButtonTapMainToAdditionalCardContentExplorationFlowTPM(
      animationController:
          animationController == null ? this.animationController : animationController(),
      mainContentFadeOutAnimation: mainContentFadeOutAnimation == null
          ? this.mainContentFadeOutAnimation
          : mainContentFadeOutAnimation(),
      additionalContentFadeInAnimation: additionalContentFadeInAnimation == null
          ? this.additionalContentFadeInAnimation
          : additionalContentFadeInAnimation(),
    );
  }
}
