import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/theme/colors.dart';

Widget toggleButton(
  BuildContext context, {
  bool defaultEnabled = true,
  required Function(bool) onTap,
}) {
  bool defaultValue = defaultEnabled;

  return Material(
    type: MaterialType.transparency,
    child: StatefulBuilder(
      builder: (context, setStateSwitch) {
        return Theme(
          data: context.brightness == Brightness.dark
              ? materialThemeDataDark
              : materialThemeDataLight,
          child: SizedBox(
            height: 32,
            width: 52,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Switch.adaptive(
                inactiveTrackColor: context.colorScheme.containerHigh,
                activeColor: context.colorScheme.primary,
                activeTrackColor: context.colorScheme.primary,
                trackOutlineColor: WidgetStateColor.transparent,
                thumbColor:
                    WidgetStatePropertyAll(context.colorScheme.onPrimary),
                value: defaultValue,
                onChanged: (value) {
                  setStateSwitch(() {
                    defaultValue = value;
                    onTap(value);
                  });
                },
              ),
            ),
          ),
        );
      },
    ),
  );
}

class ToggleButtonTile extends StatelessWidget {
  final bool defaultEnabled;
  final String title;
  final TextStyle? style;
  final Function(bool) onTap;

  const ToggleButtonTile({
    super.key,
    required this.title,
    required this.defaultEnabled,
    this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: style ??
                AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
        const SizedBox(width: 8),
        toggleButton(
          context,
          defaultEnabled: defaultEnabled,
          onTap: onTap,
        ),
      ],
    );
  }
}
