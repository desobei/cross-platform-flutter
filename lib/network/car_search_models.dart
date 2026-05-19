import 'package:json_annotation/json_annotation.dart';

part 'car_search_models.g.dart';

@JsonSerializable()
class CarSearchResults {
  const CarSearchResults({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });

  final List<CarSearchResult> results;
  final int offset;
  final int number;
  final int totalResults;

  factory CarSearchResults.fromJson(Map<String, dynamic> json) =>
      _$CarSearchResultsFromJson(json);

  Map<String, dynamic> toJson() => _$CarSearchResultsToJson(this);
}

@JsonSerializable()
class CarSearchResult {
  const CarSearchResult({
    required this.carId,
    required this.title,
    required this.image,
    required this.imageType,
    required this.tags,
  });

  final String carId;
  final String title;
  final String image;
  final String imageType;
  final List<String> tags;

  factory CarSearchResult.fromJson(Map<String, dynamic> json) =>
      _$CarSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$CarSearchResultToJson(this);
}
