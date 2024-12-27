import 'package:dio/dio.dart';
import 'package:nasa_gallery/src/core/error/error_handler.dart';
import 'package:nasa_gallery/src/core/error/exceptions.dart';
import 'package:nasa_gallery/src/data/models/nasa_image_model.dart';

abstract class ImageRemoteDataSource {
  Future<List<NasaImageModel>> getImages();
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final Dio dio;
  final String apiKey = 'hzdurLW2McgWGX6Rg4B4zfyZCK3NLRxnhs8T1YUP';
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';

  ImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NasaImageModel>> getImages() async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          'api_key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = response.data;
          return data.map((json) => NasaImageModel.fromJson(json)).toList();
        } catch (e) {
          throw InvalidDataException(
            message: 'Failed to parse server response',
            originalException: e as Exception,
          );
        }
      } else {
        throw ServerException(
          message: ErrorHandler.getServerErrorMessage(response.statusCode),
          code: response.statusCode.toString(),
        );
      }
    } on DioError catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error occurred',
        originalException: e as Exception,
      );
    }
  }
}
