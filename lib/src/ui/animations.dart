import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_photo/src/globals/numbers.dart' as numbers;

import '../data/blocs/runners/bool_runner_cubit.dart';

const Duration _animateDuration = Duration(seconds: numbers.fadeDelayDurationSeconds);
const Duration _startTransDuration = Duration(microseconds: numbers.fadeDelayDurationSeconds);

class FadeAnimator extends StatelessWidget {
  final bool doFadeIn;
  final VoidCallback? completeCallback;
  final Widget child;
  const FadeAnimator({required this.doFadeIn, this.completeCallback, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final BoolRunnerCubit runAnimationBoolCubit = BoolRunnerCubit(true);
    Future<void>.delayed(_startTransDuration, () => runAnimationBoolCubit.set(false));

    return BlocBuilder<BoolRunnerCubit, bool>(
      bloc: runAnimationBoolCubit,
      builder: (BuildContext context, bool state) => AnimatedOpacity(
        duration: _animateDuration,
        onEnd: completeCallback,
        opacity: state && doFadeIn ? 0 : 1,
        child: child,
      ),
    );
  }
}
