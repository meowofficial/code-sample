part of 'flow_tpm.dart';

class ScrollMainToAdditionalCardContentExplorationFlowTPM extends Equatable implements FlowTPM {
  const ScrollMainToAdditionalCardContentExplorationFlowTPM({
    required this.animationController,
    required this.mainContentFadeOutAnimation,
    required this.additionalContentFadeInAnimation,
    required this.released,
  });

  final AnimationController animationController;
  final Animation<double> mainContentFadeOutAnimation;
  final Animation<double> additionalContentFadeInAnimation;
  final bool released;

  @override
  List<Object?> get props {
    return [
      animationController,
      mainContentFadeOutAnimation,
      additionalContentFadeInAnimation,
      released,
    ];
  }

  ScrollMainToAdditionalCardContentExplorationFlowTPM copyWith({
    AnimationController Function()? animationController,
    Animation<double> Function()? mainContentFadeOutAnimation,
    Animation<double> Function()? additionalContentFadeInAnimation,
    bool Function()? released,
  }) {
    return ScrollMainToAdditionalCardContentExplorationFlowTPM(
      animationController:
          animationController == null ? this.animationController : animationController(),
      mainContentFadeOutAnimation: mainContentFadeOutAnimation == null
          ? this.mainContentFadeOutAnimation
          : mainContentFadeOutAnimation(),
      additionalContentFadeInAnimation: additionalContentFadeInAnimation == null
          ? this.additionalContentFadeInAnimation
          : additionalContentFadeInAnimation(),
      released: released == null ? this.released : released(),
    );
  }
}
