import 'package:flutter/material.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.l10n.tab_profile_title,
      body: Builder(
        builder: (context) {
          return Center(
            child: TextButton(onPressed: () {
              AppRoute.editProfile.push(context);
            }, child: const Text("go to profile >>")),
          );
        },
      ),
    );
  }
}
