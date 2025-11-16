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
    final mediaQueryData = MediaQuery.of(context);

    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => DisplayCubit(mediaQueryData))],
      child: BlocBuilder<DisplayCubit, DisplayState>(
        builder: (context, state) {
          return MaterialApp(title: text.titleLabel, theme: state.themeData, home: const CoreApp());
        },
      ),
    );
  }
}
