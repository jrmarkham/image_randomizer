import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/blocs/runners/bool_runner_cubit.dart';

const Duration _animateDuration = Duration(seconds: 1);
const Duration _startTransDuration = Duration(microseconds: 2);

class FadeAnimator extends StatelessWidget {
  final Widget child;
  final bool doFadeIn;

  const FadeAnimator({required this.doFadeIn, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final BoolRunnerCubit runAnimationBoolCubit = BoolRunnerCubit(true);
    Future<void>.delayed(
      _startTransDuration,
      () => runAnimationBoolCubit.set(false),
    );

    return BlocBuilder<BoolRunnerCubit, bool>(
      bloc: runAnimationBoolCubit,
      builder: (BuildContext context, bool state) => AnimatedOpacity(
        duration: _animateDuration,
        opacity: state && doFadeIn ? 0 : 1,
        child: child,
      ),
    );
  }
}
