import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_gallery/src/domain/usecases/get_images.dart';
import 'package:nasa_gallery/src/domain/usecases/search_images.dart';

import 'images_event.dart';
import 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final GetImages getImages;
  final SearchImages searchImages;

  ImagesBloc({
    required this.getImages,
    required this.searchImages,
  }) : super(ImagesInitial()) {
    on<GetImagesEvent>(_onGetImages);
    on<SearchImagesEvent>(_onSearchImages);
  }

  Future<void> _onGetImages(
    GetImagesEvent event,
    Emitter<ImagesState> emit,
  ) async {
    emit(ImagesLoading());

    final result = await getImages();

    emit(result.fold(
      (failure) => ImagesError(failure.message),
      (images) => ImagesLoaded(images),
    ));
  }

  Future<void> _onSearchImages(
    SearchImagesEvent event,
    Emitter<ImagesState> emit,
  ) async {
    emit(ImagesLoading());

    final result = await searchImages(event.query);

    emit(result.fold(
      (failure) => ImagesError(failure.message),
      (images) => ImagesLoaded(images),
    ));
  }
}
