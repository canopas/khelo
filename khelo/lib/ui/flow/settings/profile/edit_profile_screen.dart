import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPage(
      title: context.l10n.edit_profile_screen_title,
      body: Builder(
        builder: (context) {
          return ListView(
            padding: context.mediaQueryPadding +
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),

            children: const [
              // center pick profile image from camera or gallery
              CupertinoTextField(
                placeholder: "name",
              ),
              SizedBox(height: 16,),
              CupertinoTextField(
                placeholder: "email",
              ),
              SizedBox(height: 16,),
              SizedBox(height: 16,),
              CupertinoTextField(
                placeholder: "location",
              ),
              CupertinoTextField(
                placeholder: "dob",
              ),
            ],
          );
        },
      ),
    );
  }
}
