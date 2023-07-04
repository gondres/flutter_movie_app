// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_people_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularPeopleResponse _$PopularPeopleResponseFromJson(
        Map<String, dynamic> json) =>
    PopularPeopleResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$PopularPeopleResponseToJson(
        PopularPeopleResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
