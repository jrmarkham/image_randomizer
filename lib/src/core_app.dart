import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/blocs/display/display_cubit.dart';
import 'data/blocs/photo/photo_cubit.dart';
import 'globals/numbers.dart' as numbers;
import 'globals/text.dart' as text;
import 'ui/animations.dart';

class CoreApp extends StatelessWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final displayMediaData = context.watch<DisplayCubit>().state.mediaQueryData;

    final toggleThemeFunction = context.read<DisplayCubit>().toggleTheme;
    return SafeArea(
      child: BlocProvider(
        create: (context) => PhotoCubit(),
        child: Scaffold(
          appBar: AppBar(title: Text(text.titleLabel)),
          body: BlocBuilder<PhotoCubit, PhotoState>(
            builder: (context, state) {
              final loadImageFunction = context.read<PhotoCubit>().loadNewImage;
              final errorImageFunction = context.read<PhotoCubit>().errorImageLoad;
              //  final imageLoadedFunction = context.read<PhotoCubit>().imageLoadedComplete;
              final runColorTransitionFunction = context.read<PhotoCubit>().runColorTransition;
              final colorTransactionCompleteFunction = context.read<PhotoCubit>().colorTransactionComplete;

              return switch (state.status) {
                PhotoStatus.init => Column(children: [Center(child: CircularProgressIndicator())]),
                PhotoStatus.error => _ErrorDisplay(errorMessage: state.errorMessage, errorCallback: loadImageFunction),
                PhotoStatus.loadPhoto ||
                PhotoStatus.imageLoading ||
                PhotoStatus.colorTransition ||
                PhotoStatus.complete =>
                  state.imageUrl.isEmpty
                      ? Column(
                          children: [
                            Center(
                              child: ElevatedButton(
                                onPressed: loadImageFunction,
                                child: Text(text.newImageButtonLabel),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Image.network(
                                state.imageUrl,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  errorImageFunction();
                                  return SizedBox();
                                },

                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return Container(
                                      width: displayMediaData.size.width,
                                      height: displayMediaData.size.height,
                                      color: state.currentColorDetected,
                                      child: Center(
                                        child: SizedBox(
                                          width: displayMediaData.size.width * numbers.imageWidthPercentage,
                                          child: FadeAnimator(
                                            doFadeIn: true,
                                            completeCallback: runColorTransitionFunction,
                                            child: child,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),

                            //if (state.status == PhotoStatus.complete)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: numbers.imageReloadButtonBottomPadding),
                                child: ElevatedButton(
                                  onPressed: loadImageFunction,
                                  child: Text(text.newImageButtonLabel),
                                ),
                              ),
                            ),
                          ],
                        ),
              };
            },
          ),
          floatingActionButton: ElevatedButton(onPressed: toggleThemeFunction, child: Text(text.themeButtonLabel)),
        ),
      ),
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  final String errorMessage;
  final VoidCallback errorCallback;

  const _ErrorDisplay({required this.errorMessage, required this.errorCallback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(errorMessage),
          SizedBox(height: numbers.coreSpacing),
          ElevatedButton(onPressed: errorCallback, child: Text(text.errorButtonLabel)),
        ],
      ),
    );
  }
}
