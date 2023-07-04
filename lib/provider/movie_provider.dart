import 'package:flutter/material.dart';
import 'package:tmdb_movie/data/model/detail_movie_response.dart';
import 'package:tmdb_movie/data/model/movies_response.dart';

import 'package:tmdb_movie/data/model/tv_list_response.dart' as tvList;
import 'package:tmdb_movie/data/model/popular_people_response.dart'
    as peopleList;
import 'package:tmdb_movie/data/model/movies_response.dart' as moviesResponse;
import 'package:tmdb_movie/data/repository/movie_repository.dart';

import '../data/service/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService;

  MovieProvider(this._movieService);

  final MovieRepositories repositories = MovieRepositories();

  bool isSuccessPopular = false;
  bool isLoadingPopular = false;

  bool isSuccesRecommendation = false;
  bool isLoadingRecommendation = true;

  bool isSuccessTv = false;
  bool isLoadingTv = false;

  bool isSuccessDetail = false;
  bool isLoadingDetail = false;

  bool isSuccesSimilar = false;
  bool isLoadingSimilar = false;

  bool isSuccessPeople = false;
  bool isLoadingPeople = false;

  List<moviesResponse.Results> listPopular = [];
  List<moviesResponse.Results> listRecommendation = [];
  List<moviesResponse.Results> listSimilar = [];
  List<tvList.Results> listTv = [];

  List<peopleList.Results> listPeople = [];

  late var detail = DetailMovieResponse();

  Future<void> getPopularMovies() async {
    isLoadingPopular = true;
    await repositories.getPopularMovies().then((value) {
      if (value.isSuccess && value.dataResponse is MoviesResponse) {
        final response = value.dataResponse as MoviesResponse;

        for (var element in response.results!) {
          listPopular.add(element);
          debugPrint(element.toString());
        }
        isSuccessPopular = true;
        isLoadingPopular = false;
        notifyListeners();
      } else {
        isSuccessPopular = false;
        debugPrint('failed');
      }
      notifyListeners();
    });
  }

  Future<void> getRecommendationMovies() async {
    isLoadingRecommendation = true;
    await repositories.getRecommendationMovies().then((value) {
      if (value.isSuccess &&
          value.dataResponse is moviesResponse.MoviesResponse) {
        final response = value.dataResponse as moviesResponse.MoviesResponse;

        for (var element in response.results!) {
          listRecommendation.add(element);
          debugPrint(element.toString());
        }
        isSuccesRecommendation = true;
        isLoadingRecommendation = false;
        notifyListeners();
      } else {
        isSuccesRecommendation = false;
        isLoadingRecommendation = false;
        debugPrint('failed');
      }
      notifyListeners();
    });
  }

  Future<void> getTvList() async {
    isLoadingTv = true;
    await repositories.getTvList().then((value) {
      if (value.isSuccess && value.dataResponse is tvList.TvListResponse) {
        final response = value.dataResponse as tvList.TvListResponse;

        for (var element in response.results!) {
          listTv.add(element);
          debugPrint(element.toString());
        }
        isSuccessTv = true;
        isLoadingTv = false;
        notifyListeners();
      } else {
        isSuccessTv = false;
        isLoadingTv = false;
        debugPrint('failed');
      }
    });
  }

  Future<void> getDetailMovie(String id) async {
    isSuccessDetail = false;
    isLoadingDetail = true;
    await repositories.getDetailMovie(id).then((value) {
      if (value.isSuccess && value.dataResponse is DetailMovieResponse) {
        final response = value.dataResponse as DetailMovieResponse;
        detail = response;
        isSuccessDetail = true;
        isLoadingDetail = false;
        notifyListeners();
      } else {
        isLoadingDetail = false;
        debugPrint('failed');
      }
    });
    notifyListeners();
  }

  Future<void> getSimilar(String id) async {
    isLoadingSimilar = true;
    listSimilar.clear();
    await repositories.getSimilarMovie(id).then((value) {
      if (value.isSuccess &&
          value.dataResponse is moviesResponse.MoviesResponse) {
        final response = value.dataResponse as moviesResponse.MoviesResponse;
        for (var element in response.results!) {
          listSimilar.add(element);
          debugPrint(element.toString());
        }
        isSuccesSimilar = true;
        isLoadingSimilar = false;
        notifyListeners();
      } else {
        isLoadingSimilar = false;
        debugPrint('failed');
      }
    });
    notifyListeners();
  }

  Future<void> getPopularPeople() async {
    isLoadingPeople = true;
    await repositories.getPopularPeople().then((value) {
      if (value.isSuccess &&
          value.dataResponse is peopleList.PopularPeopleResponse) {
        final response = value.dataResponse as peopleList.PopularPeopleResponse;
        for (var element in response.results!) {
          listPeople.add(element);
          debugPrint('people$element');
        }
        isSuccessPeople = true;
        isLoadingPeople = false;
        notifyListeners();
      } else {
        isSuccessPeople = false;
        isLoadingPeople = false;
        debugPrint('failed');
      }
    });
    notifyListeners();
  }
}
