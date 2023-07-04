import 'package:flutter/material.dart';
import 'package:tmdb_movie/pages/detail_page.dart';
import 'package:tmdb_movie/pages/home_page.dart';

import '../base/base_routes.dart';

class AppRoutes {
  static const initialRoutes = BaseRoutes.splash;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case BaseRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case BaseRoutes.detail:
        return MaterialPageRoute(
            builder: (_) => DetailPage(
                  movie_id: '1',
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No Route defined'),
                  ),
                ));
    }
  }
}
