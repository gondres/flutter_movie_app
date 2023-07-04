import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_movie/data/model/detail_movie_response.dart';
import 'package:tmdb_movie/data/model/movies_response.dart';
import 'package:tmdb_movie/data/model/popular_people_response.dart';
import 'package:tmdb_movie/data/model/tv_list_response.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio, {String baseUrl}) = _MovieService;

  @GET(
      'discover/movie?language=en-US&sort_by=popularity.desc&with_watch_monetization_types=flatrate&include_adult=false&include_video=false&page=1')
  Future<MoviesResponse> getPopularMovies();

  @GET('movie/634649/recommendations?language=en-US&page=1')
  Future<MoviesResponse> getRecommendationMovies();

  @GET('movie/{movie_id}/similar')
  Future<MoviesResponse> getSimilarMovies(@Path('movie_id') String id);

  @GET('discover/tv')
  Future<TvListResponse> getTvList();

  @GET('movie/{movie_id}?&append_to_response=videos')
  Future<DetailMovieResponse> getDetailMovie(@Path('movie_id') String id);

  @GET('trending/person/day?language=en-US')
  Future<PopularPeopleResponse> getPopularPeople();
}
