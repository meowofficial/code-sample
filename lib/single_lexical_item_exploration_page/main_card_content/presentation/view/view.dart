import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.core/components/card_action_revealing_button/presentation/component.dart';
import 'package:mobile_app.core/components/card_additional_content_revealing_button/presentation/component.dart';
import 'package:mobile_app.core/components/card_image_content_layout/presentation/component.dart';
import 'package:mobile_app.core/components/card_pronunciation_button/presentation/component.dart';
import 'package:mobile_app.core/components/card_pronunciation_caution_button/presentation/component.dart';
import 'package:mobile_app.core/core/domain/entities/dialect.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/presentation/helpers/auto_scalable_text_mixin.dart';
import 'package:mobile_app.core/core/presentation/helpers/get_lexical_item_transcription.dart';
import 'package:mobile_app.core/core/presentation/helpers/get_localized_lexical_item_type.dart';
import 'package:mobile_app.core/core/presentation/helpers/screen_util_mixin.dart';
import 'package:mobile_app.core/core/presentation/size_configs/card_action_revealing_button_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/card_additional_content_revealing_button_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/card_main_content_size_config.dart';
import 'package:mobile_app.core/core/presentation/themes/lexical_item_card_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/translations/lexical_item_card_translation.dart';
import 'package:mobile_app.core/core/presentation/widgets/card_content_scroll_physics.dart';
import 'package:mobile_app.core/core/presentation/widgets/card_imageable_content_builder.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc_builder.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/main_card_content/presentation/vloc/vloc.dart';

class MainCardContentView extends StatelessWidget with ScreenUtilMixin, AutoScalableTextMixin {
  const MainCardContentView({
    required MainCardContentVloc vloc,
    super.key,
  }) : _vloc = vloc;

  final MainCardContentVloc _vloc;

  Widget _buildLexicalItemTranscription({
    required BuildContext context,
    required String transcription,
    required double lexicalItemHeadlineFontSize,
    required bool safeToPronounce,
  }) {
    final transcriptionFontSize = CardMainContentSizeConfig.getLexicalItemTranscriptionFontSize(
      lexicalItemHeadlineFontSize: lexicalItemHeadlineFontSize,
    );

    final transcriptionTextStyle =
        LexicalItemCardTheme.of(context).textTheme.lexicalItemTranscription(
              fontSize: transcriptionFontSize,
              letterSpacing: CardMainContentSizeConfig.getLexicalItemTranscriptionLetterSpacing(),
            );

    final transcriptionWidget = Text(
      transcription,
      style: transcriptionTextStyle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    if (safeToPronounce) {
      return transcriptionWidget;
    }

    final pronunciationCautionButtonIconSize =
        CardMainContentSizeConfig.getPronunciationCautionButtonIconSize(
      lexicalItemTranscriptionFontSize: transcriptionFontSize,
    );

    final pronunciationCautionButtonHorizontalPadding =
        CardMainContentSizeConfig.getPronunciationCautionButtonHorizontalMargin(
      pronunciationCautionButtonIconSize: pronunciationCautionButtonIconSize,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: pronunciationCautionButtonIconSize + pronunciationCautionButtonHorizontalPadding,
        ),
        Flexible(
          child: transcriptionWidget,
        ),
        CardPronunciationCautionButton(
          size: pronunciationCautionButtonIconSize,
          padding: EdgeInsets.symmetric(
            horizontal: pronunciationCautionButtonHorizontalPadding,
          ),
          onPressed: _vloc.onPronunciationCautionButtonPressed,
        ),
      ],
    );
  }

  Widget _buildImageBody({
    required BuildContext context,
    required String imagePath,
  }) {
    return ConverterVlocBuilder<MainCardContentVloc, MainCardContentVlocState,
        (LexicalItem, Dialect, bool, bool)>(
      vloc: _vloc,
      converter: (state) {
        return (
          state.lexicalItem,
          state.dialect,
          state.safeToPronounce,
          state.displayLexicalItemType,
        );
      },
      builder: (context, values) {
        final (
          lexicalItem,
          dialect,
          safeToPronounce,
          displayLexicalItemType,
        ) = values;

        final pronunciationButtonSize =
            CardMainContentSizeConfig.getImageCardPronunciationButtonSize(
          logWidthScaleFactor: logWidthScaleFactor,
        );

        final pronunciationButtonBorderWidth =
            CardMainContentSizeConfig.getImageCardPronunciationButtonGapWidth(
          logWidthScaleFactor: logWidthScaleFactor,
        );

        return CardImageContentLayout(
          cardColor: LexicalItemCardTheme.of(context).backgroundColor,
          pronunciationButtonGapWidth: pronunciationButtonBorderWidth,
          imagePath: imagePath,
          pronunciationButton: CardPronunciationButton(
            size: pronunciationButtonSize,
            onPressed: _vloc.onLexicalItemPronunciationButtonPressed,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CardMainContentSizeConfig.getTextHorizontalMargin(
                logWidthScaleFactor: logWidthScaleFactor,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final localizedLexicalItemType = getLocalizedLexicalItemType(
                  lexicalItem: lexicalItem,
                  translation: LexicalItemCardTranslation.of(context),
                );

                final lexicalItemHeadlineConstraints = BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  maxHeight: constraints.maxHeight * 0.3,
                );

                final preferredLexicalItemHeadlineFontSize =
                    CardMainContentSizeConfig.getPreferredLexicalItemHeadlineFontSize(
                  logWidthScaleFactor: logWidthScaleFactor,
                );

                final preferredLexicalItemHeadlineTextStyle =
                    LexicalItemCardTheme.of(context).textTheme.lexicalItemHeadline(
                          fontSize: preferredLexicalItemHeadlineFontSize,
                          letterSpacing:
                              CardMainContentSizeConfig.getLexicalItemHeadlineLetterSpacing(),
                        );

                final lexicalItemHeadlineMinFontSize =
                    CardMainContentSizeConfig.getMinLexicalItemHeadlineFontSize(
                  logWidthScaleFactor: logWidthScaleFactor,
                );

                const kLexicalItemHeadlineMaxLines = 2;

                final maxLexicalItemTitleFontSize = calculateFontSize(
                  text: lexicalItem.title,
                  constraints: lexicalItemHeadlineConstraints,
                  style: preferredLexicalItemHeadlineTextStyle,
                  minFontSize: lexicalItemHeadlineMinFontSize,
                  maxLines: kLexicalItemHeadlineMaxLines,
                );

                final maxLexicalItemTranslationFontSize = calculateFontSize(
                  text: lexicalItem.translation,
                  constraints: lexicalItemHeadlineConstraints,
                  style: preferredLexicalItemHeadlineTextStyle,
                  minFontSize: lexicalItemHeadlineMinFontSize,
                  maxLines: kLexicalItemHeadlineMaxLines,
                );

                final lexicalItemHeadlineFontSize =
                    CardMainContentSizeConfig.getLexicalItemHeadlineFontSize(
                  maxLexicalItemTitleFontSize: maxLexicalItemTitleFontSize,
                  maxLexicalItemTranslationFontSize: maxLexicalItemTranslationFontSize,
                );

                final lexicalItemHeadlineTextStyle = preferredLexicalItemHeadlineTextStyle.copyWith(
                  fontSize: lexicalItemHeadlineFontSize,
                );

                final lexicalItemHeadlineTextHeightBehavior = LexicalItemCardTheme.of(context)
                    .textTheme
                    .lexicalItemHeadlineTextHeightBehavior;

                final lexicalItemTranscription = getLexicalItemTranscription(
                  lexicalItem: lexicalItem,
                  dialect: dialect,
                );

                final gapBetweenLexicalItemHeadlineAndType =
                    CardMainContentSizeConfig.getGapBetweenLexicalItemHeadlineAndType(
                  logWidthScaleFactor: logWidthScaleFactor,
                );

                final lexicalItemTypeFontSize =
                    CardMainContentSizeConfig.getLexicalItemTypeFontSize(
                  logWidthScaleFactor: logWidthScaleFactor,
                );

                final lexicalItemTypeTextStyle =
                    LexicalItemCardTheme.of(context).textTheme.lexicalItemType(
                          fontSize: lexicalItemTypeFontSize,
                        );

                return Column(
                  children: [
                    const Spacer(flex: 2),
                    Text(
                      lexicalItem.title,
                      style: lexicalItemHeadlineTextStyle,
                      textAlign: TextAlign.center,
                      maxLines: kLexicalItemHeadlineMaxLines,
                      overflow: TextOverflow.ellipsis,
                      textHeightBehavior: lexicalItemHeadlineTextHeightBehavior,
                    ),
                    if (lexicalItemTranscription != null)
                      _buildLexicalItemTranscription(
                        context: context,
                        transcription: lexicalItemTranscription,
                        lexicalItemHeadlineFontSize: lexicalItemHeadlineFontSize,
                        safeToPronounce: safeToPronounce,
                      ),
                    const Spacer(flex: 2),
                    Text(
                      lexicalItem.translation,
                      style: lexicalItemHeadlineTextStyle,
                      textAlign: TextAlign.center,
                      maxLines: kLexicalItemHeadlineMaxLines,
                      overflow: TextOverflow.ellipsis,
                      textHeightBehavior: lexicalItemHeadlineTextHeightBehavior,
                    ),
                    if (displayLexicalItemType)
                      Padding(
                        padding: EdgeInsets.only(
                          top: gapBetweenLexicalItemHeadlineAndType,
                        ),
                        child: Text(
                          localizedLexicalItemType,
                          style: lexicalItemTypeTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const Spacer(flex: 3),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagelessBody({
    required BuildContext context,
  }) {
    return ConverterVlocBuilder<MainCardContentVloc, MainCardContentVlocState,
        (LexicalItem, Dialect, bool, bool)>(
      vloc: _vloc,
      converter: (state) {
        return (
          state.lexicalItem,
          state.dialect,
          state.safeToPronounce,
          state.displayLexicalItemType,
        );
      },
      builder: (context, values) {
        final (
          lexicalItem,
          dialect,
          safeToPronounce,
          displayLexicalItemType,
        ) = values;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CardMainContentSizeConfig.getTextHorizontalMargin(
              logWidthScaleFactor: logWidthScaleFactor,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final pronunciationButtonSize =
                  CardMainContentSizeConfig.getImagelessCardPronunciationButtonSize(
                logWidthScaleFactor: logWidthScaleFactor,
              );

              final localizedLexicalItemType = getLocalizedLexicalItemType(
                lexicalItem: lexicalItem,
                translation: LexicalItemCardTranslation.of(context),
              );

              final lexicalItemHeadlineConstraints = BoxConstraints(
                maxWidth: constraints.maxWidth,
                maxHeight: (constraints.maxHeight - pronunciationButtonSize) * 0.3,
              );

              final preferredLexicalItemHeadlineFontSize =
                  CardMainContentSizeConfig.getPreferredLexicalItemHeadlineFontSize(
                logWidthScaleFactor: logWidthScaleFactor,
              );

              final preferredLexicalItemHeadlineTextStyle = LexicalItemCardTheme.of(context)
                  .textTheme
                  .lexicalItemHeadline(
                    fontSize: preferredLexicalItemHeadlineFontSize,
                    letterSpacing: CardMainContentSizeConfig.getLexicalItemHeadlineLetterSpacing(),
                  );

              final lexicalItemHeadlineMinFontSize =
                  CardMainContentSizeConfig.getMinLexicalItemHeadlineFontSize(
                logWidthScaleFactor: logWidthScaleFactor,
              );

              const kLexicalItemHeadlineMaxLines = 2;

              final maxLexicalItemTitleFontSize = calculateFontSize(
                text: lexicalItem.title,
                constraints: lexicalItemHeadlineConstraints,
                style: preferredLexicalItemHeadlineTextStyle,
                minFontSize: lexicalItemHeadlineMinFontSize,
                maxLines: kLexicalItemHeadlineMaxLines,
              );

              final maxLexicalItemTranslationFontSize = calculateFontSize(
                text: lexicalItem.translation,
                constraints: lexicalItemHeadlineConstraints,
                style: preferredLexicalItemHeadlineTextStyle,
                minFontSize: lexicalItemHeadlineMinFontSize,
                maxLines: kLexicalItemHeadlineMaxLines,
              );

              final lexicalItemHeadlineFontSize =
                  CardMainContentSizeConfig.getLexicalItemHeadlineFontSize(
                maxLexicalItemTitleFontSize: maxLexicalItemTitleFontSize,
                maxLexicalItemTranslationFontSize: maxLexicalItemTranslationFontSize,
              );

              final lexicalItemHeadlineTextStyle = preferredLexicalItemHeadlineTextStyle.copyWith(
                fontSize: lexicalItemHeadlineFontSize,
              );

              final lexicalItemHeadlineTextHeightBehavior =
                  LexicalItemCardTheme.of(context).textTheme.lexicalItemHeadlineTextHeightBehavior;

              final lexicalItemTranscription = getLexicalItemTranscription(
                lexicalItem: lexicalItem,
                dialect: dialect,
              );

              final gapBetweenLexicalItemHeadlineAndType =
                  CardMainContentSizeConfig.getGapBetweenLexicalItemHeadlineAndType(
                logWidthScaleFactor: logWidthScaleFactor,
              );

              final lexicalItemTypeFontSize = CardMainContentSizeConfig.getLexicalItemTypeFontSize(
                logWidthScaleFactor: logWidthScaleFactor,
              );

              final lexicalItemTypeTextStyle =
                  LexicalItemCardTheme.of(context).textTheme.lexicalItemType(
                        fontSize: lexicalItemTypeFontSize,
                      );

              return Column(
                children: [
                  const Spacer(),
                  Text(
                    lexicalItem.title,
                    style: lexicalItemHeadlineTextStyle,
                    textAlign: TextAlign.center,
                    maxLines: kLexicalItemHeadlineMaxLines,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior: lexicalItemHeadlineTextHeightBehavior,
                  ),
                  if (lexicalItemTranscription != null)
                    _buildLexicalItemTranscription(
                      context: context,
                      transcription: lexicalItemTranscription,
                      lexicalItemHeadlineFontSize: lexicalItemHeadlineFontSize,
                      safeToPronounce: safeToPronounce,
                    ),
                  const Spacer(),
                  CardPronunciationButton(
                    size: pronunciationButtonSize,
                    onPressed: _vloc.onLexicalItemPronunciationButtonPressed,
                  ),
                  const Spacer(),
                  Text(
                    lexicalItem.translation,
                    style: lexicalItemHeadlineTextStyle,
                    textAlign: TextAlign.center,
                    maxLines: kLexicalItemHeadlineMaxLines,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior: lexicalItemHeadlineTextHeightBehavior,
                  ),
                  if (displayLexicalItemType)
                    Padding(
                      padding: EdgeInsets.only(
                        top: gapBetweenLexicalItemHeadlineAndType,
                      ),
                      child: Text(
                        localizedLexicalItemType,
                        style: lexicalItemTypeTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const Spacer(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCornerButtons() {
    return ConverterVlocBuilder<MainCardContentVloc, MainCardContentVlocState, bool>(
      vloc: _vloc,
      converter: (state) => state.additionalContentPresent,
      builder: (context, additionalContentPresent) {
        return Column(
          children: [
            CardActionRevealingButton(
              size: CardActionRevealingButtonSizeConfig.getSize(),
              padding: CardActionRevealingButtonSizeConfig.getPadding(),
              onPressed: _vloc.onCardActionRevealingButtonPressed,
            ),
            if (additionalContentPresent)
              CardAdditionalContentRevealingButton(
                size: CardAdditionalContentRevealingButtonSizeConfig.getSize(),
                padding: CardAdditionalContentRevealingButtonSizeConfig.getPadding(),
                onPressed: _vloc.onCardAdditionalContentRevealingButtonPressed,
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      delegates: const [
        LexicalItemCardTranslation.delegate,
      ],
      child: Builder(
        builder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return ConverterVlocBuilder<MainCardContentVloc, MainCardContentVlocState,
                      (bool, bool)>(
                    vloc: _vloc,
                    converter: (state) {
                      return (
                        state.allowScrollingToTop,
                        state.allowScrollingToBottom,
                      );
                    },
                    builder: (context, values) {
                      final (
                        allowScrollingToTop,
                        allowScrollingToBottom,
                      ) = values;

                      late final ScrollPhysics physics;

                      if (allowScrollingToTop && allowScrollingToBottom) {
                        physics = const DefaultCardContentScrollPhysics();
                      } else if (allowScrollingToTop) {
                        physics = const OnlyTopCardContentScrollPhysics();
                      } else if (allowScrollingToBottom) {
                        physics = const OnlyBottomCardContentScrollPhysics();
                      }

                      return SingleChildScrollView(
                        primary: false,
                        physics: physics,
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: ConverterVlocBuilder<MainCardContentVloc, MainCardContentVlocState,
                              String?>(
                            vloc: _vloc,
                            converter: (state) => state.imagePath,
                            builder: (context, imagePath) {
                              return CardImageableContentBuilder(
                                imagePath: imagePath,
                                imageContentBuilder: (context, imagePath) {
                                  return _buildImageBody(
                                    context: context,
                                    imagePath: imagePath,
                                  );
                                },
                                imagelessContentBuilder: (context) {
                                  return _buildImagelessBody(
                                    context: context,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned.fill(
                top: 7,
                right: 7,
                child: Align(
                  alignment: Alignment.topRight,
                  child: _buildCornerButtons(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
