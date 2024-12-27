import 'package:hive/hive.dart';
import 'package:nasa_gallery/src/core/error/exceptions.dart';
import 'package:nasa_gallery/src/data/models/nasa_image_model.dart';

abstract class ImageLocalDataSource {
  Future<List<NasaImageModel>> getCachedImages();
  Future<void> cacheImages(List<NasaImageModel> images);
}

class ImageLocalDataSourceImpl implements ImageLocalDataSource {
  final Box<NasaImageModel> imageBox;

  ImageLocalDataSourceImpl({required this.imageBox});

  @override
  Future<List<NasaImageModel>> getCachedImages() async {
    try {
      return imageBox.values.toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to retrieve cached images',
        originalException: e as Exception,
      );
    }
  }

  @override
  Future<void> cacheImages(List<NasaImageModel> images) async {
    try {
      await imageBox.clear();
      await imageBox.addAll(images);
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache images',
        originalException: e as Exception,
      );
    }
  }
}
