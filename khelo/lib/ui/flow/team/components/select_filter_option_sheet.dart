import 'package:data/service/team/team_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/team/team_list_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SelectFilterOptionSheet extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return const SelectFilterOptionSheet();
      },
    );
  }

  const SelectFilterOptionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(teamListViewStateProvider.notifier);

    return Container(
      padding: context.mediaQueryPadding + const EdgeInsets.only(bottom: 24),
      child: Wrap(
        children: TeamFilterOption.values
            .map((option) => _filterOptionCell(
                  context,
                  option: option,
                  onTap: () {
                    context.pop();
                    notifier.onFilterOptionSelect(option);
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _filterOptionCell(
    BuildContext context, {
    required TeamFilterOption option,
    required Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        option.getString(context),
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
