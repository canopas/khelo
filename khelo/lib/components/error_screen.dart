import 'package:data/errors/app_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/components/place_holder_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

import '../gen/assets.gen.dart';

class ErrorScreen extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetryTap;

  const ErrorScreen({super.key, required this.onRetryTap, this.error});

  @override
  Widget build(BuildContext context) {
    if (error is NoConnectionError) {
      return _noInternetConnectionScreen(context);
    } else {
      return _errorScreen(context);
    }
  }

  Widget _noInternetConnectionScreen(BuildContext context) => PlaceHolderScreen(
        image: SvgPicture.asset(
          Assets.images.icNoInternet,
          height: 140,
          width: 140,
        ),
        title: context.l10n.no_internet_error_title,
        message: context.l10n.no_internet_error_description,
        onActionBtnTap: onRetryTap,
        actionBtnTitle: context.l10n.common_retry_title,
      );

  Widget _errorScreen(BuildContext context) => PlaceHolderScreen(
        image: SvgPicture.asset(
          Assets.images.icError,
          height: 140,
          width: 140,
        ),
        title: context.l10n.something_went_wrong_error_title,
        message: context.l10n.something_went_wrong_error_description,
        onActionBtnTap: onRetryTap,
        actionBtnTitle: context.l10n.common_retry_title,
      );
}
