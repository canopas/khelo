import 'dart:math';

import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/scanner/scanner_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../components/app_page.dart';
import '../../../../components/error_snackbar.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  final List<String> addedIds;
  final ScanTarget target;

  const ScannerScreen({
    super.key,
    required this.addedIds,
    this.target = ScanTarget.player,
  });

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late final ScannerStateNotifier _notifier;

  void _observeBarcode() {
    ref.listen(scannerStateNotifierProvider.select((value) => value.scannedId),
        (prev, scannedId) async {
      if (widget.addedIds.contains(scannedId)) {
        showSnackBar(
            context,
            widget.target == ScanTarget.team
                ? context.l10n.add_team_already_added
                : context.l10n.add_team_member_already_added);
      } else if (scannedId.isNotEmpty) {
        _handleScanTarget(widget.target, scannedId);
      }
    });
  }

  void _handleScanTarget(ScanTarget target, String scannedId) async {
    switch (widget.target) {
      case ScanTarget.team:
        final team =
            await AppRoute.teamDetail(teamId: scannedId, showAddButton: true)
                .push<TeamModel>(context);
        if (mounted) context.pop(team);
        break;
      case ScanTarget.player:
        final user =
            await AppRoute.userDetail(userId: scannedId, showAddButton: true)
                .push<UserModel?>(context);
        if (mounted) context.pop(user);
        break;
    }
  }

  void _observeError() {
    ref.listen(scannerStateNotifierProvider.select((value) => value.error),
        (prev, error) {
      if (error != null) {
        showSnackBar(context, context.l10n.something_went_wrong_error_title);
      }
    });
  }

  @override
  void initState() {
    _notifier = ref.read(scannerStateNotifierProvider.notifier);
    runPostFrame(() => _notifier.setData(widget.addedIds));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _observeBarcode();
    _observeError();
    final state = ref.watch(scannerStateNotifierProvider);
    final Size size = context.mediaQuerySize;
    final scanWindow = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width,
      height: size.width,
    );
    return AppPage(
      body: Stack(
        fit: StackFit.expand,
        children: [
          (state.hasPermission)
              ? _scannerContent(scanWindow, state, size)
              : _requestPermissionView(),
        ],
      ),
    );
  }

  Widget _scannerContent(Rect scanWindow, ScannerState state, Size size) {
    return Stack(
      fit: StackFit.expand,
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _notifier.initializeController,
          overlay: QrScannerOverlayShape(
            cutOutSize: size.width,
            borderColor: Colors.transparent,
          ),
        ),
        CustomPaint(
          painter: ScannerOverlay(
              scanWindow:
                  (size.width < size.height ? size.width : size.height) / 2,
              color: context.colorScheme.primary,
              bgColor: context.brightness == Brightness.dark
                  ? Colors.black38
                  : Colors.white54),
        ),
        _topContent(state),
      ],
    );
  }

  Widget _topContent(ScannerState state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.topLeft,
                child: actionButton(
                  context,
                  onPressed: context.pop,
                  icon: Icon(
                    Icons.close,
                    color: context.colorScheme.textSecondary,
                    size: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _hintView(context),
                  const SizedBox(height: 24),
                  _flashButton(context, isFlashOn: state.flashOn),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _hintView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.containerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            context.l10n.scan_qr_code_description,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _flashButton(
    BuildContext context, {
    bool isFlashOn = false,
  }) {
    return OnTapScale(
      onTap: _notifier.toggleTorch,
      child: CircleAvatar(
          backgroundColor: isFlashOn
              ? context.colorScheme.primary
              : context.colorScheme.containerLow,
          child: SvgPicture.asset(
            Assets.images.icFlash,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
                isFlashOn
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.textPrimary,
                BlendMode.srcIn),
          )),
    );
  }

  Widget _requestPermissionView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            actionButton(
              context,
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.close,
                color: context.colorScheme.textPrimary.withValues(alpha: 0.8),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.scan_qr_permission_title,
                      style: AppTextStyle.header2.copyWith(
                        color: context.colorScheme.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.scan_qr_permission_description,
                      style: AppTextStyle.body2.copyWith(
                        color: context.colorScheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      context.l10n.scan_qr_permission_settings,
                      onPressed: () async {
                        Navigator.pop(context);
                        await openAppSettings();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    required this.color,
    this.bgColor,
    this.borderRadius = 16.0,
  });

  final double scanWindow;
  final double borderRadius;
  final Color color;
  final Color? bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final canvasRect = Offset.zero & size;

    final extend = borderRadius + 24.0;
    final arcSize = Size.square(borderRadius * 2);

    final rect = Rect.fromCircle(
      center: Offset(canvasRect.size.width / 2, canvasRect.size.height / 2.5),
      radius: scanWindow / 2,
    );

    final double cornerWidth = rect.width + borderRadius;

    canvas.drawPath(
      Path()
        ..fillType = PathFillType.evenOdd
        ..addRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(borderRadius),
          ).deflate(6 / 2),
        )
        ..addRect(canvasRect),
      Paint()..color = bgColor ?? Colors.black38,
    );

    canvas.save();
    canvas.translate(rect.left, rect.top);

    final path = Path();
    for (var i = 0; i < 4; i++) {
      final l = i & 1 == 0;
      final t = i & 2 == 0;
      path
        ..moveTo(
          l ? -borderRadius : cornerWidth,
          t ? extend - borderRadius : cornerWidth - extend,
        )
        ..arcTo(
          Offset(
                l ? -borderRadius : cornerWidth - arcSize.width,
                t ? -borderRadius : cornerWidth - arcSize.width,
              ) &
              arcSize,
          l ? pi : pi * 2,
          l == t ? pi / 2 : -pi / 2,
          false,
        )
        ..lineTo(
          l ? extend - borderRadius : cornerWidth - extend,
          t ? -borderRadius : cornerWidth,
        );
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
