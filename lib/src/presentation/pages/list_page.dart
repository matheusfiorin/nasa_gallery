import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_gallery/src/domain/entities/nasa_image.dart';
import 'package:nasa_gallery/src/presentation/bloc/images/images_bloc.dart';
import 'package:nasa_gallery/src/presentation/bloc/images/images_event.dart';
import 'package:nasa_gallery/src/presentation/bloc/images/images_state.dart';
import 'package:nasa_gallery/src/presentation/pages/detail_page.dart';
import 'package:nasa_gallery/src/presentation/widgets/image_card.dart';
import 'package:nasa_gallery/src/presentation/widgets/search_bar.dart';

class ImageListPage extends StatelessWidget {
  const ImageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NASA Gallery')),
      body: BlocBuilder<ImagesBloc, ImagesState>(
        builder: (context, state) {
          return Column(
            children: [
              NasaSearchBar(
                onSearch: (query) =>
                    context.read<ImagesBloc>().add(SearchImagesEvent(query)),
              ),
              Expanded(
                child: _buildContent(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ImagesState state) {
    if (state is ImagesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ImagesError) {
      return _buildErrorWidget(context, state.message);
    } else if (state is ImagesLoaded) {
      return _buildImageGrid(context, state.images);
    }
    return const SizedBox.shrink();
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<ImagesBloc>().add(GetImagesEvent()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context, List<NasaImage> images) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ImagesBloc>().add(GetImagesEvent());
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ImageCard(
                image: images[index],
                onTap: () => _navigateToDetail(context, images[index]),
              );
            },
          ),
        );
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  void _navigateToDetail(BuildContext context, NasaImage image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailPage(image: image),
      ),
    );
  }
}
