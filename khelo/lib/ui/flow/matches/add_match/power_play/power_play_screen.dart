import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/ui/flow/matches/add_match/power_play/power_play_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

// class PowerPlayScreen extends ConsumerWidget {
//   final int totalOvers;
//   final List<int>? firstPowerPlay;
//   final List<int>? secondPowerPlay;
//   final List<int>? thirdPowerPlay;
//
//   const PowerPlayScreen(
//       {super.key,
//       required this.totalOvers,
//       this.firstPowerPlay,
//       this.secondPowerPlay,
//       this.thirdPowerPlay});
//
//   final double widgetWidth = 50;
//   final double padding = 16.0;
//   final double spacingBetweenElements = 8.0;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     int maxOversInRow = _calculateMaxOversInRow(context);
//     double approxCellWidth = _calculateCellWidth(context, maxOversInRow);
//
//     final notifier = ref.watch(powerPlayStateProvider.notifier);
//     final state = ref.watch(powerPlayStateProvider);
//
//     return AppPage(
//       title: "Power Play Overs",
//       body: Stack(
//         children: [
//           Padding(
//             padding: context.mediaQueryPadding +
//                 EdgeInsets.symmetric(horizontal: padding) +
//                 BottomStickyOverlay.padding,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   for (final type in PowerPlayType.values) ...[
//                     _overGridView(
//                       context: context,
//                       notifier: notifier,
//                       state: state,
//                       type: type,
//                       maxOversInRow: maxOversInRow,
//                       approxCellWidth: approxCellWidth,
//                     ),
//                   ],
//                   const SizedBox(
//                     height: 50,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           _stickyButton(context, state)
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionTitle({
//     required BuildContext context,
//     required String title,
//     required bool isEnable,
//     required Function() onResetTap,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 24,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: AppTextStyle.header1
//                   .copyWith(color: context.colorScheme.textSecondary),
//             ),
//             TextButton(
//                 onPressed: isEnable ? () => onResetTap() : null,
//                 child: Text(
//                   "Reset",
//                   style: AppTextStyle.header4.copyWith(
//                       color: isEnable
//                           ? context.colorScheme.primary
//                           : context.colorScheme.textDisabled),
//                 )),
//           ],
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//       ],
//     );
//   }
//
//   Widget _overGridView({
//     required BuildContext context,
//     required PowerPlayViewNotifier notifier,
//     required PowerPlayViewState state,
//     required PowerPlayType type,
//     required int maxOversInRow,
//     required double approxCellWidth,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _sectionTitle(
//           context: context,
//           title: type.getTitle(context),
//           isEnable: true,
//           onResetTap: () => notifier.onResetButtonTap(type),
//         ),
//         for (int i = 0; i < (totalOvers / maxOversInRow).ceil(); i++) ...[
//           if (i != 0)
//             SizedBox(
//               height: padding,
//             ),
//           Row(
//             children: [
//               for (int j = 0; j < maxOversInRow; j++) ...[
//                 if (i * maxOversInRow + j < totalOvers) ...[
//                   SizedBox(
//                     width: j != 0 ? spacingBetweenElements : 0,
//                   ),
//                   _gridCellView(
//                     context: context,
//                     state: state,
//                     type: type,
//                     cellNumber: (i * maxOversInRow + j) + 1,
//                     approxCellWidth: approxCellWidth,
//                     onTap: (over) => notifier.onOverTap(over, type),
//                   )
//                 ],
//               ],
//             ],
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _gridCellView({
//     required BuildContext context,
//     required PowerPlayViewState state,
//     required PowerPlayType type,
//     required int cellNumber,
//     required double approxCellWidth,
//     required Function(int) onTap,
//   }) {
//     List<int> overList = type == PowerPlayType.one
//         ? state.firstPowerPlay
//         : type == PowerPlayType.two
//             ? state.secondPowerPlay
//             : state.thirdPowerPlay;
//
//     bool isSelected = overList.contains(cellNumber);
//
//     bool isEnabled = !(type == PowerPlayType.one
//         ? state.secondPowerPlay.contains(cellNumber) ||
//             state.thirdPowerPlay.contains(cellNumber)
//         : type == PowerPlayType.two
//             ? state.firstPowerPlay.contains(cellNumber) ||
//                 state.thirdPowerPlay.contains(cellNumber)
//             : state.secondPowerPlay.contains(cellNumber) ||
//                 state.firstPowerPlay.contains(cellNumber));
//     return OnTapScale(
//       onTap: isEnabled ? () => onTap(cellNumber) : null,
//       child: Container(
//           height: approxCellWidth,
//           width: approxCellWidth,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: isEnabled
//                   ? isSelected
//                       ? context.colorScheme.primary
//                       : context.colorScheme.containerLowOnSurface
//                   : context.colorScheme.surface,
//               border: Border.all(
//                   color: context.colorScheme.containerNormalOnSurface),
//               shape: BoxShape.circle),
//           child: Text(
//             "$cellNumber",
//             style: AppTextStyle.subtitle1.copyWith(
//                 color: isEnabled
//                     ? context.colorScheme.textPrimary
//                     : context.colorScheme.textDisabled),
//           )),
//     );
//   }
//
//   int _calculateMaxOversInRow(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width -
//         (context.mediaQueryPadding.horizontal + (padding * 2));
//
//     int maxOversInRow =
//         (screenWidth / (widgetWidth + spacingBetweenElements)).floor();
//     return maxOversInRow > 0 ? maxOversInRow : 1;
//   }
//
//   double _calculateCellWidth(BuildContext context, int maxOversInRow) {
//     double screenWidth = MediaQuery.of(context).size.width -
//         (context.mediaQueryPadding.horizontal + (padding * 2));
//     double internalPadding = ((maxOversInRow - 1) * spacingBetweenElements);
//     return ((screenWidth - internalPadding) / maxOversInRow);
//   }
//
//   Widget _stickyButton(BuildContext context, PowerPlayViewState state) {
//     return BottomStickyOverlay(
//       child: PrimaryButton(
//         "okay",
//         onPressed: () {
//           context.pop([
//             state.firstPowerPlay,
//             state.secondPowerPlay,
//             state.thirdPowerPlay
//           ]);
//         },
//       ),
//     );
//   }
// }

class PowerPlayScreen extends ConsumerStatefulWidget {
  final int totalOvers;
  final List<int>? firstPowerPlay;
  final List<int>? secondPowerPlay;
  final List<int>? thirdPowerPlay;

  const PowerPlayScreen(
      {super.key,
      required this.totalOvers,
      this.firstPowerPlay,
      this.secondPowerPlay,
      this.thirdPowerPlay});

  @override
  ConsumerState createState() => _PowerPlayScreenState();
}

class _PowerPlayScreenState extends ConsumerState<PowerPlayScreen> {
  late PowerPlayViewNotifier notifier;

  final double widgetWidth = 50;
  final double padding = 16.0;
  final double spacingBetweenElements = 8.0;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(powerPlayStateProvider.notifier);
    runPostFrame(() => notifier.setData(
        widget.firstPowerPlay, widget.secondPowerPlay, widget.thirdPowerPlay));
  }

  @override
  Widget build(BuildContext context) {
    int maxOversInRow = _calculateMaxOversInRow(context);
    double approxCellWidth = _calculateCellWidth(context, maxOversInRow);

    notifier = ref.watch(powerPlayStateProvider.notifier);
    final state = ref.watch(powerPlayStateProvider);

    return AppPage(
      title: context.l10n.power_play_screen_title,
      body: Stack(
        children: [
          Padding(
            padding: context.mediaQueryPadding +
                EdgeInsets.symmetric(horizontal: padding) +
                BottomStickyOverlay.padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final type in PowerPlayType.values) ...[
                    _overGridView(
                      context: context,
                      notifier: notifier,
                      state: state,
                      type: type,
                      maxOversInRow: maxOversInRow,
                      approxCellWidth: approxCellWidth,
                    ),
                  ],
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          _stickyButton(context, state)
        ],
      ),
    );
  }

  Widget _sectionTitle({
    required BuildContext context,
    required String title,
    required bool isEnable,
    required Function() onResetTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.header1
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            TextButton(
                onPressed: isEnable ? () => onResetTap() : null,
                child: Text(
                  context.l10n.common_reset_title,
                  style: AppTextStyle.header4.copyWith(
                      color: isEnable
                          ? context.colorScheme.primary
                          : context.colorScheme.textDisabled),
                )),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _overGridView({
    required BuildContext context,
    required PowerPlayViewNotifier notifier,
    required PowerPlayViewState state,
    required PowerPlayType type,
    required int maxOversInRow,
    required double approxCellWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          context: context,
          title: type.getTitle(context),
          isEnable: true,
          onResetTap: () => notifier.onResetButtonTap(type),
        ),
        for (int i = 0;
            i < (widget.totalOvers / maxOversInRow).ceil();
            i++) ...[
          if (i != 0)
            SizedBox(
              height: padding,
            ),
          Row(
            children: [
              for (int j = 0; j < maxOversInRow; j++) ...[
                if (i * maxOversInRow + j < widget.totalOvers) ...[
                  SizedBox(
                    width: j != 0 ? spacingBetweenElements : 0,
                  ),
                  _gridCellView(
                    context: context,
                    state: state,
                    type: type,
                    cellNumber: (i * maxOversInRow + j) + 1,
                    approxCellWidth: approxCellWidth,
                    onTap: (over) => notifier.onOverTap(over, type),
                  )
                ],
              ],
            ],
          ),
        ],
      ],
    );
  }

  Widget _gridCellView({
    required BuildContext context,
    required PowerPlayViewState state,
    required PowerPlayType type,
    required int cellNumber,
    required double approxCellWidth,
    required Function(int) onTap,
  }) {
    List<int> overList = type == PowerPlayType.one
        ? state.firstPowerPlay
        : type == PowerPlayType.two
            ? state.secondPowerPlay
            : state.thirdPowerPlay;

    bool isSelected = overList.contains(cellNumber);

    bool isEnabled = !(type == PowerPlayType.one
        ? state.secondPowerPlay.contains(cellNumber) ||
            state.thirdPowerPlay.contains(cellNumber)
        : type == PowerPlayType.two
            ? state.firstPowerPlay.contains(cellNumber) ||
                state.thirdPowerPlay.contains(cellNumber)
            : state.secondPowerPlay.contains(cellNumber) ||
                state.firstPowerPlay.contains(cellNumber));
    return OnTapScale(
      onTap: isEnabled ? () => onTap(cellNumber) : null,
      child: Container(
          height: approxCellWidth,
          width: approxCellWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isEnabled
                  ? isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.containerLowOnSurface
                  : context.colorScheme.surface,
              border: Border.all(
                  color: context.colorScheme.containerNormalOnSurface),
              shape: BoxShape.circle),
          child: Text(
            "$cellNumber",
            style: AppTextStyle.subtitle1.copyWith(
                color: isEnabled
                    ? context.colorScheme.textPrimary
                    : context.colorScheme.textDisabled),
          )),
    );
  }

  int _calculateMaxOversInRow(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -
        (context.mediaQueryPadding.horizontal + (padding * 2));

    int maxOversInRow =
        (screenWidth / (widgetWidth + spacingBetweenElements)).floor();
    return maxOversInRow > 0 ? maxOversInRow : 1;
  }

  double _calculateCellWidth(BuildContext context, int maxOversInRow) {
    double screenWidth = MediaQuery.of(context).size.width -
        (context.mediaQueryPadding.horizontal + (padding * 2));
    double internalPadding = ((maxOversInRow - 1) * spacingBetweenElements);
    return ((screenWidth - internalPadding) / maxOversInRow);
  }

  Widget _stickyButton(BuildContext context, PowerPlayViewState state) {
    return BottomStickyOverlay(
      child: PrimaryButton(
        context.l10n.common_okay_title,
        onPressed: () {
          context.pop([
            state.firstPowerPlay,
            state.secondPowerPlay,
            state.thirdPowerPlay
          ]);
        },
      ),
    );
  }
}
