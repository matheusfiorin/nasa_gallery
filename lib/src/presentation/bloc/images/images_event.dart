import 'package:equatable/equatable.dart';

abstract class ImagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetImagesEvent extends ImagesEvent {}

class SearchImagesEvent extends ImagesEvent {
  final String query;

  SearchImagesEvent(this.query);

  @override
  List<Object?> get props => [query];
}
