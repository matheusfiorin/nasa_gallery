import 'package:dartz/dartz.dart';
import 'package:nasa_gallery/src/core/error/failures.dart';
import 'package:nasa_gallery/src/domain/entities/nasa_image.dart';
import 'package:nasa_gallery/src/domain/repositories/image_repository.dart';

class SearchImages {
  final ImageRepository repository;

  SearchImages(this.repository);

  @override
  Future<Either<Failure, List<NasaImage>>> call(String query) async {
    return await repository.searchImages(query);
  }
}
