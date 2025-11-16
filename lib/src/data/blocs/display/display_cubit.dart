import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../globals/themes.dart' as theme;

part 'display_state.dart';

class DisplayCubit extends Cubit<DisplayState> {
  DisplayCubit(MediaQueryData setMediaQueryData) : super(DisplayState.init(setMediaQueryData)); // Initial theme

  void toggleTheme() {
    emit(state.copyWith(updateTheme: state.themeData == theme.lightTheme ? theme.darkTheme : theme.lightTheme));
  }
}
