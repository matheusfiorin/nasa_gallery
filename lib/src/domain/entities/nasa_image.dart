import 'package:equatable/equatable.dart';

class NasaImage extends Equatable {
  final String id;
  final String title;
  final String url;
  final DateTime date;
  final String explanation;

  const NasaImage({
    required this.id,
    required this.title,
    required this.url,
    required this.date,
    required this.explanation,
  });

  @override
  List<Object?> get props => [id, title, url, date, explanation];
}
