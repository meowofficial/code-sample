import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_app.core/components/app_back_button/presentation/component.dart';
import 'package:mobile_app.core/components/lexical_item_card/presentation/component.dart';
import 'package:mobile_app.core/components/navigation_bar_title/presentation/component.dart';
import 'package:mobile_app.core/core/domain/entities/ui_locale.dart';
import 'package:mobile_app.core/core/presentation/helpers/auto_scalable_text_mixin.dart';
import 'package:mobile_app.core/core/presentation/helpers/screen_util_mixin.dart';
import 'package:mobile_app.core/core/presentation/size_configs/card_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/navigation_bar_title_size_config.dart';
import 'package:mobile_app.core/core/presentation/themes/core_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/themes/lexical_item_card_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/translations/app_translation.dart';
import 'package:mobile_app.core/core/presentation/widgets/fade_built_transition.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc_builder.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/presentation/content.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/presentation/content.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/models/flow_pms/flow_pm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/models/flow_tpms/flow_tpm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/page/presentation/vloc/vloc.dart';

part 'translation.dart';

class SingleLexicalItemExplorationPageView extends StatelessWidget
    with ScreenUtilMixin, AutoScalableTextMixin {
  const SingleLexicalItemExplorationPageView({
    required SingleLexicalItemExplorationPageVloc vloc,
    super.key,
  }) : _vloc = vloc;

  final SingleLexicalItemExplorationPageVloc _vloc;

  Widget _buildPageBody({
    required BuildContext context,
  }) {
    return ConverterVlocBuilder<SingleLexicalItemExplorationPageVloc,
        SingleLexicalItemExplorationPageVlocState, bool>(
      vloc: _vloc,
      converter: (state) => state.blockInteractions,
      builder: (context, blockInteractions) {
        return IgnorePointer(
          ignoring: blockInteractions,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              switch (notification) {
                case ScrollStartNotification():
                  _vloc.onScrollStartNotificationReceived(notification);

                case OverscrollNotification():
                  _vloc.onOverscrollNotificationReceived(notification);

                case ScrollEndNotification():
                  _vloc.onScrollEndNotificationReceived(notification);
              }

              return false;
            },
            child: LexicalItemCard(
              cornerRadius: CardSizeConfig.getCornerRadius(
                logWidthScaleFactor: logWidthScaleFactor,
              ),
              padding: CardSizeConfig.getPadding(
                logWidthScaleFactor: logWidthScaleFactor,
              ),
              child: VlocBuilder<SingleLexicalItemExplorationPageVloc,
                  SingleLexicalItemExplorationPageVlocState>(
                vloc: _vloc,
                buildWhen: (previousState, currentState) {
                  if (currentState.currentFlowPM.runtimeType !=
                      previousState.currentFlowPM.runtimeType) {
                    return true;
                  }

                  if (currentState.nextFlowPM.runtimeType != previousState.nextFlowPM.runtimeType) {
                    return true;
                  }

                  if (currentState.flowTPM.runtimeType != previousState.flowTPM.runtimeType) {
                    return true;
                  }

                  return false;
                },
                builder: (context, state) {
                  final flowTPM = state.flowTPM;

                  switch (flowTPM) {
                    case null:
                      final currentFlowPM = state.currentFlowPM;

                      switch (currentFlowPM) {
                        case AdditionalCardContentExplorationFlowPM():
                          return AdditionalCardContent(
                            key: _vloc.state.additionalCardContentKey,
                            vloc: currentFlowPM.vloc,
                          );

                        case MainCardContentExplorationFlowPM():
                          return MainCardContent(
                            key: _vloc.state.mainCardContentKey,
                            vloc: currentFlowPM.vloc,
                          );
                      }

                    case ButtonTapAdditionalToMainCardContentExplorationFlowTPM():
                      final currentFlowPM =
                          state.currentFlowPM as AdditionalCardContentExplorationFlowPM;

                      final nextFlowPM = state.nextFlowPM as MainCardContentExplorationFlowPM;

                      return IgnorePointer(
                        ignoring: true,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FadeBuiltTransition(
                              opacity: flowTPM.additionalContentFadeOutAnimation,
                              child: AdditionalCardContent(
                                key: _vloc.state.additionalCardContentKey,
                                vloc: currentFlowPM.vloc,
                              ),
                            ),
                            FadeBuiltTransition(
                              opacity: flowTPM.mainContentFadeInAnimation,
                              child: MainCardContent(
                                key: _vloc.state.mainCardContentKey,
                                vloc: nextFlowPM.vloc,
                              ),
                            ),
                          ],
                        ),
                      );

                    case ButtonTapMainToAdditionalCardContentExplorationFlowTPM():
                      final currentFlowPM = state.currentFlowPM as MainCardContentExplorationFlowPM;
                      final nextFlowPM = state.nextFlowPM as AdditionalCardContentExplorationFlowPM;

                      return IgnorePointer(
                        ignoring: true,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FadeBuiltTransition(
                              opacity: flowTPM.mainContentFadeOutAnimation,
                              child: MainCardContent(
                                key: _vloc.state.mainCardContentKey,
                                vloc: currentFlowPM.vloc,
                              ),
                            ),
                            FadeBuiltTransition(
                              opacity: flowTPM.additionalContentFadeInAnimation,
                              child: AdditionalCardContent(
                                key: _vloc.state.additionalCardContentKey,
                                vloc: nextFlowPM.vloc,
                              ),
                            ),
                          ],
                        ),
                      );

                    case ScrollMainToAdditionalCardContentExplorationFlowTPM():
                      final currentFlowPM = state.currentFlowPM as MainCardContentExplorationFlowPM;
                      final nextFlowPM = state.nextFlowPM as AdditionalCardContentExplorationFlowPM;

                      return IgnorePointer(
                        ignoring: flowTPM.released,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FadeBuiltTransition(
                              opacity: flowTPM.mainContentFadeOutAnimation,
                              child: MainCardContent(
                                key: _vloc.state.mainCardContentKey,
                                vloc: currentFlowPM.vloc,
                              ),
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: FadeBuiltTransition(
                                opacity: flowTPM.additionalContentFadeInAnimation,
                                child: AdditionalCardContent(
                                  key: _vloc.state.additionalCardContentKey,
                                  vloc: nextFlowPM.vloc,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                    case ScrollAdditionalToMainCardContentExplorationFlowTPM():
                      final currentFlowPM =
                          state.currentFlowPM as AdditionalCardContentExplorationFlowPM;

                      final nextFlowPM = state.nextFlowPM as MainCardContentExplorationFlowPM;

                      return IgnorePointer(
                        ignoring: flowTPM.released,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FadeBuiltTransition(
                              opacity: flowTPM.additionalContentFadeOutAnimation,
                              child: AdditionalCardContent(
                                key: _vloc.state.additionalCardContentKey,
                                vloc: currentFlowPM.vloc,
                              ),
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: FadeBuiltTransition(
                                opacity: flowTPM.mainContentFadeInAnimation,
                                child: MainCardContent(
                                  key: _vloc.state.mainCardContentKey,
                                  vloc: nextFlowPM.vloc,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      delegates: const [
        _SingleLexicalItemPageTranslation.delegate,
      ],
      child: LexicalItemCardTheme(
        brightness: CoreTheme.of(context).brightness,
        child: Builder(
          builder: (context) {
            return CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: CoreTheme.of(context).backgroundColor,
              navigationBar: CupertinoNavigationBar(
                backgroundColor: CoreTheme.of(context).navigationBarColor,
                brightness: CoreTheme.of(context).brightness,
                automaticallyImplyLeading: false,
                automaticallyImplyMiddle: false,
                padding: EdgeInsetsDirectional.zero,
                middle: NavigationBarTitle(
                  preferredFontSize: NavigationBarTitleSizeConfig.getPreferredFontSize(),
                  minFontSize: NavigationBarTitleSizeConfig.getMinFontSize(),
                  title: _SingleLexicalItemPageTranslation.of(context).title,
                ),
                leading: AppBackButton(
                  onPressed: Navigator.of(context).pop,
                ),
              ),
              child: _buildPageBody(
                context: context,
              ),
            );
          },
        ),
      ),
    );
  }
}
