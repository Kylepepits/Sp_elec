import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifierProvider;
import 'package:instagram_clone_course_rtk/state/auth/models/auth_state.dart';
import 'package:instagram_clone_course_rtk/state/auth/notifiers/auth_state_notifiers.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);