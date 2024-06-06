import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style/text/app_text_style.dart';

class AppPage extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Widget? body;
  final bool automaticallyImplyLeading;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  const AppPage({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.body,
    this.automaticallyImplyLeading = true,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _cupertino(context);
    } else {
      return _material();
    }
  }

  Widget _cupertino(BuildContext context) => CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        navigationBar: (title == null && titleWidget == null) &&
                actions == null &&
                leading == null
            ? null
            : CupertinoNavigationBar(
                leading: leading,
                middle: titleWidget ?? _title(),
                border: null,
                trailing: actions == null
                    ? null
                    : actions!.length == 1
                        ? actions!.first
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!,
                          ),
                automaticallyImplyLeading: automaticallyImplyLeading,
                previousPageTitle: automaticallyImplyLeading
                    ? MaterialLocalizations.of(context).backButtonTooltip
                    : null,
              ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            body ?? const SizedBox(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: floatingActionButton ?? const SizedBox(),
              ),
            ),
          ],
        ),
      );

  Widget _material() => Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: (title == null && titleWidget == null) &&
                actions == null &&
                leading == null
            ? null
            : AppBar(
                title: titleWidget ?? _title(),
                actions: actions,
                leading: leading,
                automaticallyImplyLeading: automaticallyImplyLeading,
              ),
        body: body,
        floatingActionButton: floatingActionButton,
      );

  Widget _title() => Text(
        title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontFamily: AppTextStyle.poppinsFontFamily),
      );
}
