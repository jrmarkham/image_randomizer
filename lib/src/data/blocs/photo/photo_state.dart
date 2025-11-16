part of 'photo_cubit.dart';

enum PhotoStatus { init, error, photoLoading, complete }

@immutable
class PhotoState {
  final String imageUrl;
  final PhotoStatus status;

  //  final Image image;
  final Color colorLight;
  final Color colorDark;
  final Color currentColorDetected;
  final Color previousColorDetected;
  final String errorMessage;

  const PhotoState({
    required this.status,
    required this.imageUrl,
    required this.colorDark,
    required this.colorLight,
    required this.currentColorDetected,
    required this.previousColorDetected,
    required this.errorMessage,
  });

  const PhotoState.init()
    : status = PhotoStatus.init,
      colorDark = Colors.deepPurple,
      colorLight = Colors.amberAccent,
      currentColorDetected = Colors.blueGrey,
      previousColorDetected = Colors.blueGrey,
      imageUrl = '',
      errorMessage = '';

  const PhotoState.error(this.errorMessage)
    : status = PhotoStatus.error,
      colorDark = Colors.deepPurple,
      colorLight = Colors.amberAccent,
      currentColorDetected = Colors.blueGrey,
      previousColorDetected = Colors.blueGrey,
      imageUrl = '';

  PhotoState copyWith(
    PhotoStatus setStatus, {
    Color? updateColorDark,
    Color? updateColorLight,
    Color? updateCurrentColorDetected,

    Color? updatePreviousColorDetected,

    String? updateImageUrl,
  }) => PhotoState(
    status: setStatus,
    colorDark: updateColorDark ?? colorDark,
    colorLight: updateColorLight ?? colorLight,
    currentColorDetected: updateCurrentColorDetected ?? currentColorDetected,
    previousColorDetected: updatePreviousColorDetected ?? previousColorDetected,
    imageUrl: updateImageUrl ?? imageUrl,
    errorMessage: '',
  );


  bool get backGroundOn => status == PhotoStatus.complete ||status == PhotoStatus.photoLoading;
}
