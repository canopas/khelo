import 'package:flutter/cupertino.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MyCricketScreen extends StatefulWidget {
  const MyCricketScreen({super.key});

  @override
  State<MyCricketScreen> createState() => _MyCricketScreenState();
}

class _MyCricketScreenState extends State<MyCricketScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My cricket",
        style:
        AppTextStyle.header4.copyWith(color: context.colorScheme.primary),
      ),
    );
  }
}
