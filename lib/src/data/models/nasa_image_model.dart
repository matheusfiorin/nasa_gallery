import 'package:hive/hive.dart';
import 'package:nasa_gallery/src/domain/entities/nasa_image.dart';

part 'nasa_image_model.g.dart';

@HiveType(typeId: 0)
class NasaImageModel extends NasaImage {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String url;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String explanation;

  const NasaImageModel({
    required this.id,
    required this.title,
    required this.url,
    required this.date,
    required this.explanation,
  }) : super(
          id: id,
          title: title,
          url: url,
          date: date,
          explanation: explanation,
        );

  factory NasaImageModel.fromJson(Map<String, dynamic> json) {
    return NasaImageModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      date: DateTime.parse(json['date'] ?? ''),
      explanation: json['explanation'] ?? '',
    );
  }

  factory NasaImageModel.fromEntity(NasaImage image) {
    return NasaImageModel(
      id: image.id,
      title: image.title,
      url: image.url,
      date: image.date,
      explanation: image.explanation,
    );
  }
}
