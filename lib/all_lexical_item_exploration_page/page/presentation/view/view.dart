import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app.core/components/app_back_button/presentation/component.dart';
import 'package:mobile_app.core/components/app_search_bar/presentation/component.dart';
import 'package:mobile_app.core/components/navigation_bar_title/presentation/component.dart';
import 'package:mobile_app.core/components/tile/presentation/component.dart';
import 'package:mobile_app.core/components/tile_divider/presentation/component.dart';
import 'package:mobile_app.core/components/tile_group_header/presentation/component.dart';
import 'package:mobile_app.core/components/tile_premium_badge/presentation/component.dart';
import 'package:mobile_app.core/components/tile_rounder/presentation/component.dart';
import 'package:mobile_app.core/components/tile_trailing_navigation_indicator/presentation/component.dart';
import 'package:mobile_app.core/core/domain/entities/ui_locale.dart';
import 'package:mobile_app.core/core/presentation/helpers/screen_util_mixin.dart';
import 'package:mobile_app.core/core/presentation/size_configs/app_search_bar_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/navigation_bar_title_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/tile_layout_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/tile_premium_badge_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/tile_size_config.dart';
import 'package:mobile_app.core/core/presentation/size_configs/tile_trailing_navigation_indicator_size_config.dart';
import 'package:mobile_app.core/core/presentation/themes/core_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/themes/tile_theme/theme.dart';
import 'package:mobile_app.core/core/presentation/translations/app_translation.dart';
import 'package:mobile_app.core/core/presentation/translations/lexical_item_tile_progress_info_translation.dart';
import 'package:mobile_app.core/core/presentation/utils/screen_util.dart';
import 'package:mobile_app.core/core/presentation/widget_config.dart';
import 'package:mobile_app.core/core/presentation/widgets/platform_keyboard_placeholder.dart';
import 'package:mobile_app.core/core/presentation/widgets/vloc_builder.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/models/lexical_item_pm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/models/lexical_item_progress_pms/lexical_item_progress_pm.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/vloc/vloc.dart';

part 'translation.dart';

class AllLexicalItemExplorationPageView extends StatelessWidget with ScreenUtilMixin {
  const AllLexicalItemExplorationPageView({
    required AllLexicalItemExplorationPageVloc vloc,
    super.key,
  }) : _vloc = vloc;

  final AllLexicalItemExplorationPageVloc _vloc;

  Widget _buildLexicalItemTileGroupHeader() {
    return ConverterVlocBuilder<AllLexicalItemExplorationPageVloc,
        AllLexicalItemExplorationPageVlocState, int>(
      vloc: _vloc,
      converter: (state) => state.filteredLexicalItemPMs.length,
      builder: (context, lexicalItemCount) {
        final text =
            _AllLexicalItemExplorationPageTranslation.of(context).buildLexicalItemTileGroupHeader(
          lexicalItemCount: lexicalItemCount,
        );

        return Align(
          alignment: Alignment.centerLeft,
          child: TileGroupHeader(
            fontSize: TileLayoutSizeConfig.getTileGroupHeaderFontSize(),
            padding: TileLayoutSizeConfig.getTileGroupHeaderPadding(),
            text: text,
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return AppSearchBar(
      fontSize: AppSearchBarSizeConfig.getFontSize(),
      letterSpacing: AppSearchBarSizeConfig.getLetterSpacing(),
      padding: AppSearchBarSizeConfig.getPadding(),
      searchIconPadding: AppSearchBarSizeConfig.getSearchIconPadding(),
      clearIconPadding: AppSearchBarSizeConfig.getClearIconPadding(),
      searchIconSize: AppSearchBarSizeConfig.getSearchIconSize(),
      clearIconSize: AppSearchBarSizeConfig.getClearIconSize(),
      cornerRadius: AppSearchBarSizeConfig.getCornerRadius(),
      controller: _vloc.state.searchBarTextEditingController,
      focusNode: _vloc.state.searchBarFocusNode,
      textInputAction: TextInputAction.newline,
      onChanged: _vloc.onSearchBarTextChanged,
    );
  }

  Widget _buildLexicalItemTile({
    required BuildContext context,
    required LexicalItemPM lexicalItemPM,
  }) {
    final translation = LexicalItemTileProgressInfoTranslation.of(context);

    final progressPM = lexicalItemPM.progressPM;

    final String progressInfo;

    switch (progressPM) {
      case ExcludedLexicalItemProgressPM():
        progressInfo = translation.excludedLexicalItemProgressInfo;

      case UnspecifiedLexicalItemProgressPM():
        progressInfo = translation.unspecifiedLexicalItemProgressInfo;

      case PreviouslyKnownLexicalItemProgressPM():
        progressInfo = translation.previouslyKnownLexicalItemProgressInfo;

      case CompletelyLearnedLexicalItemProgressPM():
        progressInfo = translation.completelyLearnedProgressInfo;

      case LearningLexicalItemProgressPM():
        progressInfo = translation.getLearningProgressInfo(
          progressPercent: progressPM.progressPercent,
        );
    }

    final titleTextStyle = TileTheme.of(context).textTheme.title(
          fontSize: TileSizeConfig.getTitleFontSize(),
          letterSpacing: TileSizeConfig.getTitleLetterSpacing(),
        );

    final boldTitleTextStyle = TileTheme.of(context).textTheme.boldTitle(
          fontSize: TileSizeConfig.getTitleFontSize(),
          letterSpacing: TileSizeConfig.getTitleLetterSpacing(),
        );

    final subtitleTextStyle = TileTheme.of(context).textTheme.subtitle(
          fontSize: TileSizeConfig.getSubtitleFontSize(),
          letterSpacing: TileSizeConfig.getSubtitleLetterSpacing(),
        );

    final body = Padding(
      padding: TileSizeConfig.getTitleWithSubtitlePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: TileSizeConfig.getTitleMinHeight(),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: lexicalItemPM.title,
                          style: boldTitleTextStyle,
                        ),
                        TextSpan(
                          text: '  –  ${lexicalItemPM.translation}',
                          style: titleTextStyle,
                        ),
                      ],
                    ),
                    textWidthBasis: TextWidthBasis.longestLine,
                    textHeightBehavior: TileTheme.of(context).textTheme.titleTextHeightBehavior,
                  ),
                ),
                if (!lexicalItemPM.permitted)
                  Padding(
                    padding: EdgeInsets.only(
                      left: TileSizeConfig.getGapBetweenTextTileTitleAndPremiumBadge(),
                    ),
                    child: TilePremiumBadge(
                      cornerRadius: TilePremiumBadgeSizeConfig.getCornerRadius(),
                      fontSize: TilePremiumBadgeSizeConfig.getFontSize(),
                      padding: TilePremiumBadgeSizeConfig.getPadding(),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: TileSizeConfig.getGapBetweenTitleAndSubtitle(),
          ),
          Text(
            progressInfo,
            style: subtitleTextStyle,
          ),
        ],
      ),
    );

    final leading = SizedBox(
      width: TileSizeConfig.getEmptyLeadingMargin(),
    );

    final trailing = TileTrailingNavigationIndicator(
      padding: TileTrailingNavigationIndicatorSizeConfig.getPadding(),
      iconSize: TileTrailingNavigationIndicatorSizeConfig.getIconSize(),
    );

    return Tile(
      minHeight: TileSizeConfig.getMinHeight(),
      onPressed: () {
        _vloc.onLexicalItemTilePressed(
          lexicalItemId: lexicalItemPM.id,
        );
      },
      leading: leading,
      body: body,
      trailing: trailing,
    );
  }

  Widget _buildLexicalItemSliverList() {
    return ConverterVlocBuilder<AllLexicalItemExplorationPageVloc,
        AllLexicalItemExplorationPageVlocState, BuiltList<LexicalItemPM>>(
      vloc: _vloc,
      converter: (state) => state.filteredLexicalItemPMs,
      builder: (context, filteredLexicalItemPMs) {
        return SliverList.separated(
          itemCount: filteredLexicalItemPMs.length,
          itemBuilder: (context, index) {
            final lexicalItemPM = filteredLexicalItemPMs[index];

            var lexicalItemTile = _buildLexicalItemTile(
              context: context,
              lexicalItemPM: lexicalItemPM,
            );

            if (index == 0) {
              lexicalItemTile = TileRounder(
                top: true,
                bottom: false,
                cornerRadius: TileSizeConfig.getCornerRadius(),
                child: lexicalItemTile,
              );
            }

            if (index == filteredLexicalItemPMs.length - 1) {
              lexicalItemTile = TileRounder(
                top: false,
                bottom: true,
                cornerRadius: TileSizeConfig.getCornerRadius(),
                child: lexicalItemTile,
              );
            }

            return lexicalItemTile;
          },
          separatorBuilder: (context, index) {
            return const TileDivider();
          },
        );
      },
    );
  }

  Widget _buildKeyboardPlaceholder({
    required BuildContext context,
  }) {
    return PlatformKeyboardPlaceholder(
      tabBarHeight: kTabBarHeight + ScreenUtil().bottomBarHeight,
      backgroundColor: CoreTheme.of(context).backgroundColor,
    );
  }

  Widget _buildPageBody({
    required BuildContext context,
  }) {
    final slivers = <Widget>[
      SliverList.list(
        children: [
          SizedBox(
            height: TileLayoutSizeConfig.getGapBetweenTiles(),
          ),
          _buildSearchBar(),
          SizedBox(
            height: TileLayoutSizeConfig.getGapBetweenTiles(),
          ),
          _buildLexicalItemTileGroupHeader(),
        ],
      ),
      _buildLexicalItemSliverList(),
      SliverSafeArea(
        sliver: SliverList.list(
          children: [
            SizedBox(
              height: TileLayoutSizeConfig.getGapBetweenTiles(),
            ),
            _buildKeyboardPlaceholder(
              context: context,
            ),
          ],
        ),
      ),
    ];

    return Scrollbar(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TileLayoutSizeConfig.getTileHorizontalMargin(
            logWidthScaleFactor: logWidthScaleFactor,
          ),
        ),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: _vloc.onLexicalItemTilesScrolled,
            child: CustomScrollView(
              primary: true,
              physics: ScrollConfiguration.of(context).getScrollPhysics(context),
              slivers: slivers,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      delegates: const [
        _AllLexicalItemExplorationPageTranslation.delegate,
        LexicalItemTileProgressInfoTranslation.delegate,
      ],
      child: TileTheme(
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
                  title: _AllLexicalItemExplorationPageTranslation.of(context).title,
                ),
                leading: AppBackButton(
                  onPressed: Navigator.of(context).pop,
                ),
              ),
              child: SizedBox.expand(
                child: _buildPageBody(
                  context: context,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
