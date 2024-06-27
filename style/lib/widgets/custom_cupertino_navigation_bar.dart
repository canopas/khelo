import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:style/extensions/context_extensions.dart';

class CustomCupertinoNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final bool automaticallyImplyLeading;
  final String? previousPageTitle;
  final Color? backgroundColor;
  final EdgeInsets padding;

  const CustomCupertinoNavigationBar({
    Key? key,
    this.leading,
    this.middle,
    this.trailing,
    this.automaticallyImplyLeading = true,
    this.previousPageTitle,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      context.brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
        border: null,
      ),
      child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: kMinInteractiveDimension,
            child: NavigationToolbar(
              leading: leadingWidget(context),
              middle: middleWidget(context),
              trailing: trailingWidget(),
              middleSpacing: 6.0,
            ),
          )),
    );
  }

  Widget leadingWidget(BuildContext context) {
    if (automaticallyImplyLeading && Navigator.of(context).canPop()) {
      return CupertinoNavigationBarBackButton(
        previousPageTitle: previousPageTitle,
        onPressed: () => Navigator.maybePop(context),
      );
    }
    if (leading != null && !automaticallyImplyLeading) return leading!;
    return const SizedBox();
  }

  Widget middleWidget(BuildContext context) {
    return DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
      child: middle ?? const SizedBox(),
    );
  }

  Widget trailingWidget() {
    return (trailing != null)
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: trailing!,
          )
        : const SizedBox();
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kMinInteractiveDimension + padding.vertical);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
