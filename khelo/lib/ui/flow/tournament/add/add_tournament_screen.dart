import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/profile_image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/tournament/add/add_tournament_view_model.dart';
import 'package:style/extensions/context_extensions.dart';

import '../../../../components/image_picker_sheet.dart';

class AddTournamentScreen extends ConsumerStatefulWidget {
  const AddTournamentScreen({super.key});

  @override
  ConsumerState<AddTournamentScreen> createState() =>
      _AddTournamentScreenState();
}

class _AddTournamentScreenState extends ConsumerState<AddTournamentScreen> {
  late AddTournamentViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(addTournamentStateProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.l10n.add_tournament_screen_title,
      body: Builder(
        builder: (context) => _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(addTournamentStateProvider);
    return ListView(
      children: [
        _topHeader(context, state),
      ],
    );
  }

  Widget _topHeader(BuildContext context, AddTournamentState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ProfileImageAvatar(
        size: 120,
        isLoading: state.imageUploading && state.profileFilePath == null,
        shape: BoxShape.rectangle,
        filePath: state.profileFilePath,
        imageUrl: state.profileImageUrl,
        placeHolderImage: Assets.images.icTournaments,
        placeHolderColor: context.colorScheme.textPrimary,
        color: context.colorScheme.containerHigh,
        borderRadius: BorderRadius.circular(16),
        onEditButtonTap: () async {
          final imagePath = await ImagePickerSheet.show<String>(context, true);
          if (imagePath != null) {
            notifier.onImageChange(imagePath);
          }
        },
      ),
    );
  }
}
