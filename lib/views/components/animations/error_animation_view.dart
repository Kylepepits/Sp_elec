import 'package:instagram_clone_course_rtk/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_clone_course_rtk/views/components/animations/models/lottie_animation.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
          reverse: true,
        );
}