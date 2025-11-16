part of 'display_cubit.dart';

@immutable
class DisplayState {
  final ThemeData themeData;
  final MediaQueryData mediaQueryData;

  const DisplayState({required this.themeData, required this.mediaQueryData});

  DisplayState.init(this.mediaQueryData) : themeData = theme.lightTheme;

  DisplayState copyWith({required ThemeData updateTheme}) =>
      DisplayState(mediaQueryData: mediaQueryData, themeData: updateTheme);
}
