import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_gallery/src/core/injection.dart';
import 'package:nasa_gallery/src/presentation/bloc/images/images_bloc.dart';
import 'package:nasa_gallery/src/presentation/bloc/images/images_event.dart';
import 'package:nasa_gallery/src/presentation/pages/list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ImagesBloc>()..add(GetImagesEvent()),
      child: MaterialApp(
        title: 'NASA Gallery',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: const ImageListPage(),
      ),
    );
  }
}
