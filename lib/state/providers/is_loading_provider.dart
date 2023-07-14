import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course_rtk/state/image_upload/providers/image_uploader_provider.dart';

import '../auth/providers/auth_state_provider.dart';

// @riverpod
final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  // final isSendingComment = ref.watch(sendCommentProvider);
  // final isDeletingComment = ref.watch(deleteCommentProvider);
  // final isDeletingPost = ref.watch(deletePostProvider);
  return authState.isLoading
  || isUploadingImage;
  // return authState.isLoading ||
  //     isUploadingImage ||
  //     isSendingComment ||
  //     isDeletingComment ||
  //     isDeletingPost;
});