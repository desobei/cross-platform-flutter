// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_search_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarSearchResults _$CarSearchResultsFromJson(Map<String, dynamic> json) =>
    CarSearchResults(
      results: (json['results'] as List<dynamic>)
          .map((e) => CarSearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: (json['offset'] as num).toInt(),
      number: (json['number'] as num).toInt(),
      totalResults: (json['totalResults'] as num).toInt(),
    );

Map<String, dynamic> _$CarSearchResultsToJson(CarSearchResults instance) =>
    <String, dynamic>{
      'results': instance.results,
      'offset': instance.offset,
      'number': instance.number,
      'totalResults': instance.totalResults,
    };

CarSearchResult _$CarSearchResultFromJson(Map<String, dynamic> json) =>
    CarSearchResult(
      carId: json['carId'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      imageType: json['imageType'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CarSearchResultToJson(CarSearchResult instance) =>
    <String, dynamic>{
      'carId': instance.carId,
      'title': instance.title,
      'image': instance.image,
      'imageType': instance.imageType,
      'tags': instance.tags,
    };
