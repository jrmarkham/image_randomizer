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
              return Column(
                children: [
                  /// ADD SWITCH BY STATUS ///
                  // Text('Photo State :: ${state.status}'),
                  // Text('Photo State :: ${state.imageUrl}'),

                  if (state.status == PhotoStatus.error) ...[
                    Text(state.errorMessage),
                    ElevatedButton(onPressed: loadImageFunction, child: Text(text.errorButtonLabel)),
                  ],

                  if (state.imageUrl.isNotEmpty) ...[
                   Image.network(
                        state.imageUrl,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          errorImageFunction();
                          return SizedBox();
                        },

                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return Container(
                              width: displayMediaData.size.width,
                              height: displayMediaData.size.height * 0.65,
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

                    ElevatedButton(onPressed: loadImageFunction, child: Text(text.newImageButtonLabel)),

                  ],
                ],
              );
            },
          ),
          floatingActionButton: ElevatedButton(onPressed: toggleThemeFunction, child: Text(text.themeButtonLabel)),
        ),
      ),
    );
  }
}
