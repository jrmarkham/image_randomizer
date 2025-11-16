import 'package:dominant_color_detector/dominant_color_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../globals/text.dart' as text;
import '../../mixin/photo_cubit_mixin.dart';
import '../../services/photo_service.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> with PhotoCubitMixin {
  late final BasePhotoService _photoService;

  PhotoCubit({PhotoService? setPhotoService}) : super(PhotoState.init()) {
    _photoService = setPhotoService ?? PhotoService();
    _loadImage();
  }

  void loadNewImage() => _loadImage();

  void errorImageLoad() => emit(PhotoState.error(text.errorImageFailedToLoad));

  void colorTransactionComplete() => emit(state.copyWith(PhotoStatus.complete));

  void _loadImage() async {
    emit(state.copyWith(PhotoStatus.photoLoading));
    final imageUrl = await _photoService.getPhotoUrl();
    debugPrint('PhotoCubit _loadImage $imageUrl');
    if (imageUrl.isEmpty) {
      emit(PhotoState.error(text.errorNoImageData));
      return;
    }

    /// GET COLOR FOR IMAGE
    final imageBytes = await _photoService.getPhotoBytes(imageUrl);

    if (imageBytes != null) {
      final dominateColor = await DominantColorDetector.analyze(imageBytes);

      /// GET UNIQUE COLOR FOR IMAGE
      final newColor = getColorFromDominateResults(dominateColor: dominateColor, lastColor: state.currentColorDetected);

      emit(
        state.copyWith(
          PhotoStatus.photoLoading,
          updateImageUrl: imageUrl,
          updateCurrentColorDetected: newColor,
          updatePreviousColorDetected: state.currentColorDetected,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        PhotoStatus.photoLoading,
        updateImageUrl: imageUrl,
        updatePreviousColorDetected: state.currentColorDetected,
      ),
    );
  }
}
