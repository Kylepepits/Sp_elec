import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course_rtk/state/auth/providers/auth_state_provider.dart';
import '../models/auth_result.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch (authStateProvider);
  return authState.result == AuthResult.success;
});