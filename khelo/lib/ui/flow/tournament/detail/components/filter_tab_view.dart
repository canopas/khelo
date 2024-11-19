import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../gen/assets.gen.dart';

class FilterTabView extends StatelessWidget {
  final String title;
  final String filterValue;
  final VoidCallback onFilter;

  const FilterTabView({
    super.key,
    required this.title,
    required this.onFilter,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.header4.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          ),
        ),
        TextButton.icon(
          iconAlignment: IconAlignment.end,
          onPressed: onFilter,
          label: Text(
            filterValue,
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          icon: SvgPicture.asset(
            Assets.images.icArrowDown,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
              context.colorScheme.primary,
              BlendMode.srcATop,
            ),
          ),
        ),
      ],
    );
  }
}
