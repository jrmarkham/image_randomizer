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


  void runColorTransition() => emit(state.copyWith(PhotoStatus.colorTransition));

  void colorTransactionComplete() => emit(state.copyWith(PhotoStatus.complete));

  void _loadImage() async {
    emit(state.copyWith(PhotoStatus.imageLoading));
    final imageUrl = await _photoService.getPhotoUrl();
    debugPrint('PhotoCubit _loadFirstImage $imageUrl');
    if (imageUrl.isEmpty) {
      emit(PhotoState.error(text.errorNoImageData));
      return;
    }


    final imageBytes = await _photoService.getPhotoBytes(imageUrl);

  if(imageBytes != null) {
    final dominateColor = await DominantColorDetector.analyze(imageBytes);
    final newColor = getColorFromDominateResults(dominateColor);


    debugPrint('FIRST: ${dominateColor.first.color.label}');

    for (final result in dominateColor) {
      debugPrint('${result.color.label}: ${(result.percentage).toStringAsFixed(0)}%');
    }

    emit(state.copyWith(PhotoStatus.loadPhoto, updateImageUrl: imageUrl,
    updateCurrentColorDetected: newColor,
      updatePreviousColorDetected: state.currentColorDetected
    ));
    return;
  }
    emit(state.copyWith(PhotoStatus.loadPhoto, updateImageUrl: imageUrl,
        updatePreviousColorDetected: state.currentColorDetected
    ));


  }
}

class Strng {}
