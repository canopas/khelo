class StorageConst {
  static String rootDirectory = "images";

  static String userProfileUploadPath({
    required String userId,
  }) =>
      "$rootDirectory/$userId/profile";

  static String teamProfileUploadPath({
    required String userId,
    required String teamId,
  }) =>
      "$rootDirectory/$userId/team_profile_images/$teamId";

  static String supportAttachmentUploadPath({
    required String userId,
    required String imageName,
  }) =>
      "$rootDirectory/$userId/support_attachment_images/$imageName";
}
