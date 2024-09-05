import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/match_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/home/search/search_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/search_text_field.dart';

class SearchHomeScreen extends ConsumerStatefulWidget {
  final List<MatchModel> matches;

  const SearchHomeScreen({
    super.key,
    required this.matches,
  });

  @override
  ConsumerState<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends ConsumerState<SearchHomeScreen> {
  late SearchHomeViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(searchHomeViewProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matches));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchHomeViewProvider);
    return AppPage(
      automaticallyImplyLeading: false,
      body: Padding(
        padding: context.mediaQueryPadding + const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBarField(context, state),
            Divider(
              color: context.colorScheme.outline,
              height: 24,
              thickness: 1,
            ),
            if (state.searchedMatches.isEmpty) ...[
              Expanded(
                child: EmptyScreen(
                  title: (state.searchController.text.isNotEmpty)
                      ? context.l10n.home_match_list_empty_search_title
                      : context.l10n.home_search_empty_title,
                  description: (state.searchController.text.isNotEmpty)
                      ? context.l10n.home_match_list_empty_search_message
                      : context.l10n.home_search_empty_message,
                  isShowButton: false,
                ),
              ),
            ] else ...[
              _searchedList(context, state.searchedMatches),
            ],
          ],
        ),
      ),
    );
  }

  Widget _searchBarField(BuildContext context, SearchHomeViewState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        actionButton(context,
            onPressed: context.pop,
            icon: Icon(
              CupertinoIcons.chevron_back,
              size: 24,
              color: context.colorScheme.textPrimary,
            )),
        Expanded(
          child: SearchTextField(
            controller: state.searchController,
            hintText: context.l10n.home_search_hint_title,
            suffixIcon: (state.searchController.text.isNotEmpty)
                ? actionButton(
                    context,
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.colorScheme.textDisabled,
                    ),
                    onPressed: notifier.onClear,
                  )
                : null,
            onChange: notifier.onChange,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _searchedList(BuildContext context, List<MatchModel> matches) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 1 + matches.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            context.l10n.home_search_results_title,
            style: AppTextStyle.header3.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          );
        }
        final match = matches[index - 1];
        return MatchDetailCell(
          match: match,
          onTap: () => AppRoute.matchDetailTab(matchId: match.id ?? ""),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    ));
  }
}
