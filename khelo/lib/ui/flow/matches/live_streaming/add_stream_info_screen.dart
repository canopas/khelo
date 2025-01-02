import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';

import '../../../../domain/extensions/widget_extension.dart';
import 'add_stream_info_view_model.dart';

class AddStreamInfoScreen extends ConsumerStatefulWidget {
  final String matchId;

  const AddStreamInfoScreen({super.key, required this.matchId});

  @override
  ConsumerState createState() => _AddStreamInfoScreenState();
}

class _AddStreamInfoScreenState extends ConsumerState<AddStreamInfoScreen> {
  late AddStreamInfoViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addStreamInfoStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.matchId));
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "ADD INFO",
      body: Container(),
    );
  }
}
