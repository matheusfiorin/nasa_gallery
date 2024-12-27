import 'package:equatable/equatable.dart';
import 'package:nasa_gallery/src/domain/entities/nasa_image.dart';

abstract class ImagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImagesInitial extends ImagesState {}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<NasaImage> images;

  ImagesLoaded(this.images);

  @override
  List<Object?> get props => [images];
}

class ImagesError extends ImagesState {
  final String message;

  ImagesError(this.message);

  @override
  List<Object?> get props => [message];
}
