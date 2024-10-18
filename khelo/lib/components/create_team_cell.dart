import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../ui/app_route.dart';

Widget createTeamCell(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: context.colorScheme.containerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline)),
    child: Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.common_create_team_description,
            style: AppTextStyle.body2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 36,
          child: PrimaryButton(
            context.l10n.common_create_team_title,
            expanded: false,
            onPressed: () => AppRoute.addTeam().push(context),
          ),
        ),
      ],
    ),
  );
}
