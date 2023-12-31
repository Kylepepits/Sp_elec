// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course_rtk/state/posts/providers/user_posts_provider.dart';
import 'package:instagram_clone_course_rtk/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone_course_rtk/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_course_rtk/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_course_rtk/views/components/post/post_grid_view.dart';
import 'package:instagram_clone_course_rtk/views/constants/strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return PostsGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}