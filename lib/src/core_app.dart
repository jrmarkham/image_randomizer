import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/blocs/display/display_cubit.dart';
import 'data/blocs/photo/photo_cubit.dart';
import 'globals/numbers.dart' as numbers;
import 'globals/text.dart' as text;

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
              return Column(
                children: [
                  /// ADD SWITCH BY STATUS ///
                  Text('Photo State :: ${state.status}'),
                  Text('Photo State :: ${state.imageUrl}'),
                  if (state.imageUrl.isNotEmpty) ...[
                    SizedBox(
                      width:
                          displayMediaData.size.width *
                          numbers.imageWidthPercentage,
                      child: Image.network(
                        state.imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                    ElevatedButton(
                      onPressed: loadImageFunction,
                      child: Text(text.newImageButtonLabel),
                    ),
                  ],
                ],
              );
            },
          ),
          floatingActionButton: ElevatedButton(
            onPressed: toggleThemeFunction,
            child: Text(text.themeButtonLabel),
          ),
        ),
      ),
    );
  }
}
