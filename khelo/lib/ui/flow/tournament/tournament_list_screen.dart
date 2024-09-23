import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';

class TournamentListScreen extends ConsumerStatefulWidget {
  const TournamentListScreen({super.key});

  @override
  ConsumerState<TournamentListScreen> createState() =>
      _TournamentListScreenState();
}

class _TournamentListScreenState extends ConsumerState<TournamentListScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Builder(
        builder: (context) => _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return const Column();
  }
}
