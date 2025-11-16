import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core_app.dart';
import 'src/data/blocs/display/display_cubit.dart';
import 'src/globals/text.dart' as text;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => DisplayCubit(mediaQuerySize))],
      child: kIsWeb
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final Size newSize = Size(constraints.maxWidth, constraints.maxHeight);

                debugPrint('Size update $newSize');

                context.read<DisplayCubit>().updateMediaSize(newSize);
                return _DisplayContent();
              },
            )
          : _DisplayContent(),
    );
  }
}

class _DisplayContent extends StatelessWidget {
  const _DisplayContent();

  @override
  Widget build(BuildContext context) => BlocBuilder<DisplayCubit, DisplayState>(
    builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: text.titleLabel,
        theme: state.themeData,
        home: const CoreApp(),
      );
    },
  );
}

//LayoutBuilder
