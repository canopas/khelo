import 'package:cached_network_image/cached_network_image.dart';

import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/extensions/image_provider_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../components/match_status_tag.dart';
import '../../../../domain/formatter/date_formatter.dart';
import '../../../../gen/assets.gen.dart';

class TournamentItem extends StatefulWidget {
  final TournamentModel tournament;
  final EdgeInsets margin;
  final Size? size;

  const TournamentItem({
    super.key,
    this.size,
    required this.tournament,
    this.margin = EdgeInsets.zero,
  });

  @override
  State<TournamentItem> createState() => _TournamentItemState();
}

class _TournamentItemState extends State<TournamentItem> {
  late ImageProvider imageProvider;

  PaletteGenerator? palette;

  @override
  void initState() {
    super.initState();
    if (widget.tournament.banner_img_url != null) {
      imageProvider =
          CachedNetworkImageProvider(widget.tournament.banner_img_url!);
      imageProvider.createPaletteGenerator().then((palette) {
        if (mounted) {
          setState(() => this.palette = palette);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.size?.width ?? context.mediaQuerySize.width;
    final (titleColor, dateAndTypeColor) = _getTextColors();
    return OnTapScale(
      onTap: () => AppRoute.tournamentDetail(tournamentId: widget.tournament.id)
          .push(context),
      child: Container(
        height: width / 2,
        width: width,
        margin: widget.margin,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: context.colorScheme.containerNormalOnSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            _bannerImage(widget.tournament.banner_img_url, width),
            _gradient(context, width),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _titleAndStatus(
                    title: widget.tournament.name,
                    status: widget.tournament.status,
                    titleColor: titleColor,
                  ),
                  const SizedBox(height: 4),
                  _dateAndType(
                    startTime: widget.tournament.start_date,
                    endTime: widget.tournament.end_date,
                    type: widget.tournament.type,
                    dateAndTypeColor: dateAndTypeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gradient(BuildContext context, double width) {
    final dominant =
        palette?.dominantColor?.color ?? context.colorScheme.primary;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: width / 2,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              dominant.withOpacity(0),
              dominant.withOpacity(0.5),
              dominant,
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerImage(String? bannerUrl, double width) {
    return bannerUrl == null
        ? Center(
            child: SvgPicture.asset(Assets.images.icTournaments,
                height: 32,
                width: 32,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textPrimary,
                  BlendMode.srcATop,
                )),
          )
        : CachedNetworkImage(
            imageUrl: bannerUrl,
            fit: BoxFit.cover,
            width: width,
            height: width / 2,
          );
  }

  Widget _titleAndStatus(
      {required String title,
      required TournamentStatus status,
      required Color titleColor}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.subtitle1.copyWith(
              color: titleColor,
            ),
            overflow: TextOverflow.ellipsis,
            textScaler: TextScaler.noScaling,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 16),
        StatusTag(tournamentStatus: status)
      ],
    );
  }

  Widget _dateAndType(
      {required DateTime startTime,
      required DateTime endTime,
      required TournamentType type,
      required Color dateAndTypeColor}) {
    return Text.rich(
        overflow: TextOverflow.ellipsis,
        TextSpan(
            text: DateFormatter.formatDateRange(
              context,
              startDate: startTime,
              endDate: endTime,
              formatType: DateFormatType.dayMonth,
            ),
            style: AppTextStyle.caption.copyWith(
              color: dateAndTypeColor,
            ),
            children: [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    height: 5,
                    width: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dateAndTypeColor,
                    ),
                  )),
              TextSpan(text: type.getString(context))
            ]));
  }

  (Color, Color) _getTextColors() {
    final dominant =
        palette?.dominantColor?.color ?? context.colorScheme.primary;

    if (dominant == context.colorScheme.primary) {
      return (
        context.colorScheme.onPrimary,
        context.colorScheme.onPrimary.withOpacity(0.8)
      );
    }

    if (dominant.computeLuminance() < 0.5) {
      return (Colors.white, Colors.white.withOpacity(0.8));
    } else {
      return (Colors.black.withOpacity(0.87), Colors.black.withOpacity(0.6));
    }
  }
}
