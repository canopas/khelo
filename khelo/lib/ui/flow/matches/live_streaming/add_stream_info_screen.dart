import 'package:data/api/live_stream/live_stream_model.dart';
import 'package:data/service/live_stream/live_stream_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../components/error_screen.dart';
import '../../../../components/error_snackbar.dart';
import '../../../../domain/extensions/widget_extension.dart';
import '../../../../gen/assets.gen.dart';
import 'add_stream_info_view_model.dart';

class AddStreamInfoScreen extends ConsumerStatefulWidget {
  final String matchId;

  const AddStreamInfoScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _AddStreamInfoScreenState();
}

class _AddStreamInfoScreenState extends ConsumerState<AddStreamInfoScreen> {
  late AddStreamInfoViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addStreamInfoStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addStreamInfoStateProvider);

    _observeActionError(context, ref);
    _observeYTChannels(context, ref);
    _observeShowSelectResolutionSheet(context, ref);

    return AppPage(
      title: context.l10n.add_stream_info_title,
      body: Builder(builder: (context) {
        return _body(context, state);
      }),
    );
  }

  Widget _body(BuildContext context, AddStreamInfoViewState state) {
    if (state.loading) {
      return Center(child: AppProgressIndicator());
    }
    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.loadData,
      );
    }

    return ListView(
      children: [
        if (state.stream == null) ...[
          _mediumOptionView(context),
        ] else ...[
          Container(
            padding: EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: context.colorScheme.outline),
            ),
            child: Column(
              spacing: 16,
              children: [
                Text(
                  context.l10n.add_stream_info_all_set_title,
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                Text(context.l10n.add_stream_info_all_set_description,
                    style: AppTextStyle.subtitle2
                        .copyWith(color: context.colorScheme.textPrimary)),
                PrimaryButton(
                  context.l10n.add_stream_info_go_live_title,
                  expanded: false,
                  onPressed: () =>
                      AppRoute.streamCameraView(stream: state.stream!)
                          .push(context),
                ),
              ],
            ),
          )
        ]
      ],
    );
  }

  Widget _mediumOptionView(BuildContext context) {
    return Padding(
      padding: context.mediaQueryPadding + const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          spacing: 16,
          children: [
            // TODO: remove unlink button
            ElevatedButton(
                onPressed: () => notifier.unlink(), child: Text("Unlink")),
            Text(
              context.l10n.add_stream_info_go_live_with_text,
              style: AppTextStyle.header4
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            ...MediumOption.values.map(
              (option) => _mediumCellView(context, option),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mediumCellView(BuildContext context, MediumOption option) {
    return OnTapScale(
      onTap: () => notifier.onOptionSelected(option),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.colorScheme.containerNormal,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.images.icYoutube,
              colorFilter:
                  ColorFilter.mode(context.colorScheme.alert, BlendMode.srcIn),
              height: 20,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.getString(context),
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textPrimary)),
                  if (option.isLoginRequired)
                    Text(
                      context.l10n.add_stream_info_login_required_text,
                      style: AppTextStyle.caption
                          .copyWith(color: context.colorScheme.textSecondary),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(addStreamInfoStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeYTChannels(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(addStreamInfoStateProvider.select((value) => value.ytChannels),
        (previous, next) {
      if (next.isNotEmpty) {
        chooseYTChannelSheet(context, next);
      }
    });
  }

  void _observeShowSelectResolutionSheet(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen(addStreamInfoStateProvider.select((value) => value.showSelectResolutionSheet),
        (previous, next) {
      if (next) {
        chooseYTResolutionSheet(context);
      }
    });
  }

  void chooseYTChannelSheet(BuildContext context, List<YTChannel> channelList) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return SizedBox(
          height: context.mediaQuerySize.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  context.l10n.add_stream_info_choose_channel,
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          ytChannelCell(context, channel: channelList[index]),
                      separatorBuilder: (context, index) =>
                          Divider(color: context.colorScheme.outline),
                      itemCount: channelList.length)),
            ],
          ),
        );
      },
    );
  }

  void chooseYTResolutionSheet(BuildContext context) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return SizedBox(
          height: context.mediaQuerySize.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  context.l10n.add_stream_info_choose_resolution,
                  style: AppTextStyle.header4
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          Text(YouTubeResolution.values[index].name),
                      separatorBuilder: (context, index) =>
                          Divider(color: context.colorScheme.outline),
                      itemCount: YouTubeResolution.values.length)),
            ],
          ),
        );
      },
    );
  }

  Widget ytChannelCell(BuildContext context, {required YTChannel channel}) {
    return OnTapScale(
      onTap: () => notifier.onChannelSelect(channel.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Text(
          channel.title,
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.textPrimary),
        ),
      ),
    );
  }
}
