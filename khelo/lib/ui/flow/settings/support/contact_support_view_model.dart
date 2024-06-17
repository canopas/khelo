import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_support_view_model.freezed.dart';

final contactSupportStateNotifierProvider = StateNotifierProvider.autoDispose<
    ContactSupportViewStateNotifier, ContactSupportViewStat>((ref) {
  return ContactSupportViewStateNotifier();
});

class ContactSupportViewStateNotifier
    extends StateNotifier<ContactSupportViewStat> {
  ContactSupportViewStateNotifier()
      : super(
          ContactSupportViewStat(
              titleController: TextEditingController(),
              descriptionController: TextEditingController()),
        );

  void onValueChange() {
    state = state.copyWith(
        actionError: null,
        enableSubmit: state.titleController.text.trim().isNotEmpty);
  }
}

@freezed
class ContactSupportViewStat with _$ContactSupportViewStat {
  const factory ContactSupportViewStat({
    @Default(false) bool submitting,
    @Default(false) bool enableSubmit,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    Object? actionError,
  }) = _ContactSupportViewStat;
}
