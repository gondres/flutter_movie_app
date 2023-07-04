import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/data/service/movie_service.dart';
import 'package:tmdb_movie/pages/splash_screen_page.dart';
import 'package:tmdb_movie/provider/movie_provider.dart';
import 'package:tmdb_movie/utils/app_route.dart';
import 'package:tmdb_movie/utils/app_services.dart';
import 'package:tmdb_movie/base/base_api.dart' as baseApi;
import 'package:dio/dio.dart';
import 'package:tmdb_movie/utils/register_dio.dart';

import 'database/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: 'TMDB Movie'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final serviceUtil = ServiceUtil();

  @override
  void initState() {
    registerAppServices();
    DatabaseHelper.instance.database;
    super.initState();
  }

  Future<void> registerAppServices() async {
    serviceUtil.initDio();
    final appServices = AppServices(GetIt.I.get<Dio>());
    await appServices.registerServices(baseApi.base_url);
  }

  @override
  Widget build(BuildContext context) {
    final service = MovieService(Dio());
    return ChangeNotifierProvider(
        create: (context) => MovieProvider(service),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoutes,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashScreenPage(),
        ));
  }
}
