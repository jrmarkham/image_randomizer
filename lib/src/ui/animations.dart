import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_photo/src/globals/numbers.dart' as numbers;

import '../data/blocs/runners/bool_runner_cubit.dart';

const Duration _animateFadeDuration = Duration(seconds: numbers.fadeDelayDurationSeconds);
const Duration _fadeDurationDelay = Duration(microseconds: numbers.fadeDelayDurationSeconds);

const Duration _animateColorDuration = Duration(seconds: numbers.colorDurationSeconds);

class FadeAnimator extends StatelessWidget {
  final bool doFadeIn;
  final VoidCallback? completeCallback;
  final Widget child;

  const FadeAnimator({this.doFadeIn = true, this.completeCallback, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final BoolRunnerCubit runAnimationBoolCubit = BoolRunnerCubit(true);
    Future<void>.delayed(_fadeDurationDelay, () => runAnimationBoolCubit.set(false));

    return BlocBuilder<BoolRunnerCubit, bool>(
      bloc: runAnimationBoolCubit,
      builder: (BuildContext context, bool state) => AnimatedOpacity(
        duration: _animateFadeDuration,
        onEnd: completeCallback,
        opacity: state && doFadeIn ? 0 : 1,
        child: child,
      ),
    );
  }
}

class ColorTweenAnimation extends StatefulWidget {
  final double width;
  final double height;
  final Color colorStart;
  final Color colorFinish;
  final Widget child;

  const ColorTweenAnimation({
    required this.width,
    required this.height,
    required this.colorStart,
    required this.colorFinish,
    required this.child,
    super.key,
  });

  @override
  State<ColorTweenAnimation> createState() => _ColorTweenAnimationState();
}

class _ColorTweenAnimationState extends State<ColorTweenAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animateColorDuration);
    _colorAnimation = ColorTween(begin: widget.colorStart, end: widget.colorFinish).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _colorAnimation,
    builder: (context, child) =>
        Container(color: _colorAnimation.value, width: widget.width, height: widget.height, child: widget.child),
  );
}
