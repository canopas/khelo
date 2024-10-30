import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class OfficialsCellView extends StatelessWidget {
  final MatchOfficials type;
  final UserModel? user;
  final bool isWholeCellTappable;
  final VoidCallback onCardTap;
  final VoidCallback? onRemoveTap;

  const OfficialsCellView({
    super.key,
    required this.type,
    this.user,
    this.isWholeCellTappable = false,
    required this.onCardTap,
    this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    final double margin = user == null || onRemoveTap == null ? 16 : 24;
    return OnTapScale(
      onTap: () => onCardTap(),
      enabled: isWholeCellTappable,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(
                top: isWholeCellTappable ? 0 : margin, right: margin),
            decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: OnTapScale(
              onTap: () => onCardTap(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _cellImageView(
                    context,
                    placeHolderImage: type.getImagePath(),
                    imageUrl: user?.profile_img_url,
                    nameInitial: user?.nameInitial,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.name ?? type.getTitle(context),
                    style: AppTextStyle.subtitle3
                        .copyWith(color: context.colorScheme.textPrimary),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          if (user != null && onRemoveTap != null)
            _removeUserButton(context, onTap: onRemoveTap!),
        ],
      ),
    );
  }

  Widget _removeUserButton(
    BuildContext context, {
    required VoidCallback onTap,
  }) {
    return OnTapScale(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: context.colorScheme.surface,
                border: Border.all(color: context.colorScheme.textPrimary),
                shape: BoxShape.circle),
          ),
          Icon(
            Icons.close,
            size: 16,
            color: context.colorScheme.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _cellImageView(
    BuildContext context, {
    String? imageUrl,
    String? nameInitial,
    required String placeHolderImage,
  }) {
    return imageUrl == null && nameInitial == null
        ? SvgPicture.asset(
            placeHolderImage,
            colorFilter: ColorFilter.mode(
                context.colorScheme.textPrimary, BlendMode.srcIn),
          )
        : ImageAvatar(
            initial: nameInitial ?? "?",
            imageUrl: imageUrl,
            size: 58,
          );
  }
}
