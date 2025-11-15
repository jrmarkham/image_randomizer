import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_photo/src/data/services/photo_service.dart';


part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  late final BasePhotoService _photoService;
  PhotoCubit({PhotoService? setPhotoService}) : super(PhotoState.init()) {
    _photoService = setPhotoService ?? PhotoService();
    _loadImage();

  }



  void loadNewImage() => _loadImage();


  void _loadImage() async {
    emit(state.copyWith(
        PhotoStatus.imageLoading
    ));
    final imageUrl = await _photoService.getPhotoUrl();
    debugPrint ('PhotoCubit _loadFirstImage $imageUrl');
    if(imageUrl.isEmpty) {
      emit(PhotoState.error('No Image Data'));
      return;
    }
    emit(state.copyWith(PhotoStatus.loadPhoto,
    updateImageUrl: imageUrl
    ));


  }
}

class Strng {
}
