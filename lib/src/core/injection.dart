import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nasa_gallery/src/data/datasources/local/image_local_datasource.dart';
import 'package:nasa_gallery/src/data/datasources/remote/image_remote_datasource.dart';
import 'package:nasa_gallery/src/data/datasources/repositories/image_repository_impl.dart';
import 'package:nasa_gallery/src/data/models/nasa_image_model.dart';
import 'package:nasa_gallery/src/domain/repositories/image_repository.dart';
import 'package:nasa_gallery/src/domain/usecases/get_images.dart';
import 'package:nasa_gallery/src/domain/usecases/search_images.dart';
import 'package:nasa_gallery/src/presentation/bloc/images/images_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  sl.registerLazySingleton(() => Dio());
  // sl.registerLazySingleton(() => Connectivity());

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(NasaImageModelAdapter());
  final imageBox = await Hive.openBox<NasaImageModel>('nasa_images');
  sl.registerLazySingleton(() => imageBox);

  // Data sources
  sl.registerLazySingleton<ImageRemoteDataSource>(
    () => ImageRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ImageLocalDataSource>(
    () => ImageLocalDataSourceImpl(imageBox: sl()),
  );

  // Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetImages(sl()));
  sl.registerLazySingleton(() => SearchImages(sl()));

  // BLoC
  sl.registerFactory(
    () => ImagesBloc(
      getImages: sl(),
      searchImages: sl(),
    ),
  );
}
