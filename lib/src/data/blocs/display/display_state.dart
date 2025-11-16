part of 'display_cubit.dart';

@immutable
class DisplayState {
  final ThemeData themeData;
  final Size mediaSize;

  const DisplayState({required this.themeData, required this.mediaSize});

  DisplayState.init(this.mediaSize) : themeData = theme.lightTheme;

  DisplayState copyWith({ThemeData? updateTheme, Size? updateMediaSize}) =>
      DisplayState(mediaSize: updateMediaSize ?? mediaSize, themeData: updateTheme ?? themeData);
}
