import 'package:flutter/cupertino.dart';
import 'package:tmdb_movie/data/service/movie_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../model/repository_response.dart';

class MovieRepositories {
  Future<RepositoriesResponse> getPopularMovies() async {
    final services = GetIt.I.get<MovieService>();

    late RepositoriesResponse response;

    try {
      await services.getPopularMovies().then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo popular');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo popular');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500 $e');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500 popular');

    return response;
  }

  Future<RepositoriesResponse> getRecommendationMovies() async {
    final services = GetIt.I.get<MovieService>();

    late RepositoriesResponse response;

    try {
      await services.getRecommendationMovies().then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo recommendation');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo recommendation');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500 $e recommendation');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500 recommendation');

    return response;
  }

  Future<RepositoriesResponse> getTvList() async {
    final services = GetIt.I.get<MovieService>();

    late RepositoriesResponse response;

    try {
      await services.getTvList().then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo tv');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo tv');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500 $e tv');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500 tv');

    return response;
  }

  Future<RepositoriesResponse> getDetailMovie(String id) async {
    final services = GetIt.I.get<MovieService>();

    late RepositoriesResponse response;

    try {
      await services.getDetailMovie(id).then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo detail');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo detail');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500 $e detail');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500 detail');

    return response;
  }

  Future<RepositoriesResponse> getSimilarMovie(String id) async {
    final services = GetIt.I.get<MovieService>();

    late RepositoriesResponse response;

    try {
      await services.getSimilarMovies(id).then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo similar');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo similar');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500 $e similar');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500 similar');

    return response;
  }

  Future<RepositoriesResponse> getPopularPeople() async {
    final services = GetIt.I.get<MovieService>();

    late RepositoriesResponse response;

    try {
      await services.getPopularPeople().then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo people');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo people');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500 $e people');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500 people');

    return response;
  }
}
