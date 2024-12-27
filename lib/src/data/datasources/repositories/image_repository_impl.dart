import 'package:dartz/dartz.dart';
import 'package:nasa_gallery/src/core/error/exceptions.dart';
import 'package:nasa_gallery/src/core/error/failures.dart';
import 'package:nasa_gallery/src/data/datasources/local/image_local_datasource.dart';
import 'package:nasa_gallery/src/data/datasources/remote/image_remote_datasource.dart';
import 'package:nasa_gallery/src/data/models/nasa_image_model.dart';
import 'package:nasa_gallery/src/domain/entities/nasa_image.dart';
import 'package:nasa_gallery/src/domain/repositories/image_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;
  final ImageLocalDataSource localDataSource;

  ImageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<NasaImage>>> getImages() async {
    try {
      // TODO - fix connectivity
      final connectivityResult = true;
      if (connectivityResult == ConnectivityResult.none) {
        final localImages = await localDataSource.getCachedImages();
        return Right(localImages);
      }

      final remoteImages = await remoteDataSource.getImages();
      await localDataSource.cacheImages(remoteImages);
      return Right(remoteImages);
    } on ServerException {
      return const Left(ServerFailure());
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<NasaImage>>> searchImages(String query) async {
    try {
      final images = await localDataSource.getCachedImages();
      final filteredImages = images
          .where((image) =>
              image.title.toLowerCase().contains(query.toLowerCase()) ||
              image.date.toString().contains(query))
          .toList();
      return Right(filteredImages);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> cacheImages(List<NasaImage> images) async {
    try {
      final imagesToCache =
          images.map((image) => NasaImageModel.fromEntity(image)).toList();

      await localDataSource.cacheImages(imagesToCache);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(CacheFailure('Unexpected error while caching images'));
    }
  }
}
