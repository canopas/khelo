import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';

class MatchDetailTabScreen extends ConsumerStatefulWidget {
  final String matchId;

  const MatchDetailTabScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _MatchDetailTabScreenState();
}

class _MatchDetailTabScreenState extends ConsumerState<MatchDetailTabScreen> {
  late MatchDetailTabViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(matchDetailTabStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    notifier = ref.watch(matchDetailTabStateProvider.notifier);

    return DefaultTabController(
      length: MatchDetailTab.values.length,
      child: AppPage(
        title: context.l10n.match_detail_screen_title,
        tabBar: TabBar(
          tabAlignment: TabAlignment.start,
          indicatorColor: context.colorScheme.primary,
          labelColor: context.colorScheme.primary,
          unselectedLabelColor: context.colorScheme.textSecondary,
          dividerColor: context.colorScheme.outline,
          splashFactory: NoSplash.splashFactory,
          isScrollable: true,
          tabs: MatchDetailTab.values
              .map((tab) => Tab(text: tab.getString(context)))
              .toList(),
        ),
        body: TabBarView(
            children: MatchDetailTab.values
                .map((tab) => tab.getTabScreen())
                .toList()),
      ),
    );
  }
}
