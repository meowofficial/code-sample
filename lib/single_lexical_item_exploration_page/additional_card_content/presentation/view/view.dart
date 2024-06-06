import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.core/components/card_additional_content_closing_button/presentation/component.dart';
import 'package:mobile_app.core/components/usage_example_leading_pronunciation_button/presentation/component.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/presentation/helpers/screen_util_mixin.dart';
import 'package:mobile_app.core/core/presentation/size_configs/card_additional_content_closing_button_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/card_additional_content_size_config.dart';
import 'package:mobile_app.core/core/presentation/themes/lexical_item_card_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/translations/lexical_item_card_translation.dart';
import 'package:mobile_app.core/core/presentation/widgets/card_content_scroll_physics.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc_builder.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/single_lexical_item_exploration_page/additional_card_content/presentation/vloc/vloc.dart';

class AdditionalCardContentView extends StatelessWidget with ScreenUtilMixin {
  const AdditionalCardContentView({
    required AdditionalCardContentVloc vloc,
    super.key,
  }) : _vloc = vloc;

  final AdditionalCardContentVloc _vloc;

  Widget _buildUsageExample({
    required BuildContext context,
    required LexicalItemUsageExample usageExample,
  }) {
    final leadingSize =
        CardAdditionalContentSizeConfig.getUsageExampleLeadingPronunciationButtonSize(
      logWidthScaleFactor: logWidthScaleFactor,
    );

    final leadingIconSize =
        CardAdditionalContentSizeConfig.getUsageExampleLeadingPronunciationIconSize(
      logWidthScaleFactor: logWidthScaleFactor,
    );

    final leading = UsageExampleLeadingPronunciationButton(
      size: leadingSize,
      iconSize: leadingIconSize,
      onPressed: () {
        _vloc.onUsageExamplePronunciationButtonPressed(usageExample);
      },
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: leading,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUsageExampleText(
                  context: context,
                  text: usageExample.titleMarkdown,
                  fontStyle: FontStyle.normal,
                ),
                SizedBox(
                  height:
                      CardAdditionalContentSizeConfig.getGapBetweenUsageExampleTitleAndTranslation(
                    logWidthScaleFactor: logWidthScaleFactor,
                  ),
                ),
                _buildUsageExampleText(
                  context: context,
                  text: usageExample.translationMarkdown,
                  fontStyle: FontStyle.italic,
                ),
              ],
            ),
          ),
          SizedBox(
            width: CardAdditionalContentSizeConfig.getUsageExampleTrailingWidth(
              logWidthScaleFactor: logWidthScaleFactor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageExampleText({
    required BuildContext context,
    required String text,
    required FontStyle fontStyle,
  }) {
    final parts = text.split('#');

    final textSpans = <TextSpan>[];

    for (var i = 0; i < parts.length; i++) {
      final fontSize = CardAdditionalContentSizeConfig.getUsageExampleTextFontSize(
        logWidthScaleFactor: logWidthScaleFactor,
      );

      final letterSpacing = CardAdditionalContentSizeConfig.getUsageExampleTextLetterSpacing();

      final textStyle = LexicalItemCardTheme.of(context).textTheme.usageExampleText(
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            bold: i.isOdd,
            fontStyle: fontStyle,
          );

      final textSpan = TextSpan(
        text: parts[i],
        style: textStyle,
      );

      textSpans.add(textSpan);
    }

    final textHeightBehavior =
        LexicalItemCardTheme.of(context).textTheme.usageExampleTextHeightBehavior;

    return Text.rich(
      TextSpan(
        children: textSpans,
      ),
      textHeightBehavior: textHeightBehavior,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildUsageExampleSliverList() {
    return ConverterVlocBuilder<AdditionalCardContentVloc, AdditionalCardContentVlocState,
        BuiltList<LexicalItemUsageExample>>(
      vloc: _vloc,
      converter: (state) => state.usageExamples,
      builder: (context, usageExamples) {
        return SliverList.separated(
          itemCount: usageExamples.length,
          itemBuilder: (context, index) {
            return _buildUsageExample(
              context: context,
              usageExample: usageExamples[index],
            );
          },
          separatorBuilder: (context, index) {
            final gapHeight = CardAdditionalContentSizeConfig.getGapBetweenUsageExamples(
              logWidthScaleFactor: logWidthScaleFactor,
            );

            return SizedBox(
              height: gapHeight,
            );
          },
        );
      },
    );
  }

  Widget _buildUsageExampleBlockTitle({
    required BuildContext context,
  }) {
    final fontSize = CardAdditionalContentSizeConfig.getUsageExampleBlockTitleFontSize(
      logWidthScaleFactor: logWidthScaleFactor,
    );

    final textStyle = LexicalItemCardTheme.of(context).textTheme.usageExampleBlockTitle(
          fontSize: fontSize,
        );

    return Text(
      LexicalItemCardTranslation.of(context).usageExampleBlockTitle,
      style: textStyle,
    );
  }

  Widget _buildContent({
    required BuildContext context,
  }) {
    return SizedBox.expand(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: ConverterVlocBuilder<AdditionalCardContentVloc, AdditionalCardContentVlocState,
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

            return CustomScrollView(
              key: _vloc.state.scrollViewKey,
              primary: true,
              physics: physics,
              slivers: [
                SliverList.list(
                  children: [
                    Padding(
                      padding: CardAdditionalContentSizeConfig.getUsageExampleBlockTitlePadding(
                        logWidthScaleFactor: logWidthScaleFactor,
                      ),
                      child: _buildUsageExampleBlockTitle(
                        context: context,
                      ),
                    ),
                  ],
                ),
                _buildUsageExampleSliverList(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: CardAdditionalContentSizeConfig.getBottomMargin(
                      logWidthScaleFactor: logWidthScaleFactor,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildClosingButton({
    required BuildContext context,
  }) {
    return CardAdditionalContentClosingButton(
      size: CardAdditionalContentClosingButtonSizeConfig.getSize(),
      padding: CardAdditionalContentClosingButtonSizeConfig.getPadding(),
      onPressed: _vloc.onAdditionalContentButtonClosingPressed,
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
              _buildContent(
                context: context,
              ),
              Positioned.fill(
                top: 4,
                right: 4,
                child: Align(
                  alignment: Alignment.topRight,
                  child: _buildClosingButton(
                    context: context,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
