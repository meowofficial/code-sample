part of 'flow_tpm.dart';

class ScrollAdditionalToMainCardContentExplorationFlowTPM extends Equatable implements FlowTPM {
  const ScrollAdditionalToMainCardContentExplorationFlowTPM({
    required this.animationController,
    required this.additionalContentFadeOutAnimation,
    required this.mainContentFadeInAnimation,
    required this.released,
  });

  final AnimationController animationController;
  final Animation<double> additionalContentFadeOutAnimation;
  final Animation<double> mainContentFadeInAnimation;
  final bool released;

  @override
  List<Object?> get props {
    return [
      animationController,
      additionalContentFadeOutAnimation,
      mainContentFadeInAnimation,
      released,
    ];
  }

  ScrollAdditionalToMainCardContentExplorationFlowTPM copyWith({
    AnimationController Function()? animationController,
    Animation<double> Function()? additionalContentFadeOutAnimation,
    Animation<double> Function()? mainContentFadeInAnimation,
    bool Function()? released,
  }) {
    return ScrollAdditionalToMainCardContentExplorationFlowTPM(
      animationController:
          animationController == null ? this.animationController : animationController(),
      additionalContentFadeOutAnimation: additionalContentFadeOutAnimation == null
          ? this.additionalContentFadeOutAnimation
          : additionalContentFadeOutAnimation(),
      mainContentFadeInAnimation: mainContentFadeInAnimation == null
          ? this.mainContentFadeInAnimation
          : mainContentFadeInAnimation(),
      released: released == null ? this.released : released(),
    );
  }
}
