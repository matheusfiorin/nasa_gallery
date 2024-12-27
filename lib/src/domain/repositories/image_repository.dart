import 'package:dartz/dartz.dart';
import 'package:nasa_gallery/src/core/error/failures.dart';
import 'package:nasa_gallery/src/domain/entities/nasa_image.dart';

abstract class ImageRepository {
  Future<Either<Failure, List<NasaImage>>> getImages();
  Future<Either<Failure, List<NasaImage>>> searchImages(String query);
  Future<Either<Failure, void>> cacheImages(List<NasaImage> images);
}
