import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPage(
      title: context.l10n.edit_profile_screen_title,
      body: Builder(
        builder: (context) {
          return const Center(child: Text("Edit Profile Screen"),);
        },
      ),
    );
  }
}
