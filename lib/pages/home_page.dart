import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/pages/detail_page.dart';
import 'package:tmdb_movie/pages/watch_later_page.dart';
import 'package:tmdb_movie/provider/movie_provider.dart';
import 'package:tmdb_movie/utils/list_view_widget.dart';
import 'package:tmdb_movie/utils/media_query.dart';
import 'package:tmdb_movie/utils/skelton_loader.dart';
import 'package:tmdb_movie/base/base_api.dart' as baseApi;
import 'package:tmdb_movie/base/base_colors.dart' as baseColors;
import 'package:tmdb_movie/base/base_image.dart' as baseImage;
import 'package:tmdb_movie/base/base_dimens.dart' as baseDimens;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdjustScreen mediaQuery = AdjustScreen();

  @override
  void initState() {
    // TODO: implement initState

    fetchMovies();
    getPopularPeople();
    super.initState();
  }

  Future<void> fetchMovies() async {
    var provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getPopularMovies();
    if (provider.listPopular.isNotEmpty && provider.isSuccessPopular) {
      await provider.getRecommendationMovies();
      if (provider.listRecommendation.isNotEmpty &&
          provider.isSuccesRecommendation) {
        await provider.getTvList();
      }
    }
  }

  Future<void> getPopularPeople() async {
    var provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getPopularPeople();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: baseColors.colorBackground,
            title: Image(
              image: const AssetImage(baseImage.appLogo),
              width: mediaQuery.screenWidth(context, 3),
              height: mediaQuery.screenHeight(context, 3),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WatchLaterPage()));
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: baseColors.colorSecondary,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 10),
                    child: Text(
                      'Popular Movies',
                      style: TextStyle(
                          fontSize: baseDimens.fontSize24,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    color: baseColors.colorPrimary,
                    child: Consumer<MovieProvider>(
                        builder: (context, value, child) {
                      if (value.isLoadingPopular) {
                        return SizedBox(
                          height: mediaQuery.screenWidth(context, 1.4),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, index) {
                                return const SkeltonLoader(length: 5);
                              }),
                        );
                      }
                      if (value.isSuccessPopular &&
                          value.listPopular.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: mediaQuery.screenWidth(context, 1.4),
                                  child: ListWidget(
                                    response: value.listPopular,
                                  )),
                            ],
                          ),
                        );
                      }

                      return const Text('Failed');
                    }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 10),
                    child: Text(
                      'Recommendation Movies',
                      style: TextStyle(
                          fontSize: baseDimens.fontSize24,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    color: baseColors.colorPrimary,
                    child: Consumer<MovieProvider>(
                        builder: (context, value, child) {
                      if (value.isLoadingRecommendation) {
                        return SizedBox(
                          height: mediaQuery.screenWidth(context, 1.4),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, index) {
                                return const SkeltonLoader(length: 5);
                              }),
                        );
                      }
                      if (value.isSuccesRecommendation &&
                          value.listRecommendation.isNotEmpty) {
                        return SizedBox(
                            height: mediaQuery.screenWidth(context, 1.4),
                            child: ListWidget(
                              response: value.listRecommendation,
                            ));
                      }

                      return const Text('Failed');
                    }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 10),
                    child: Text(
                      'TV Show',
                      style: TextStyle(
                          fontSize: baseDimens.fontSize24,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    color: baseColors.colorPrimary,
                    child: Consumer<MovieProvider>(
                        builder: (context, value, child) {
                      if (value.isLoadingPopular) {
                        return SizedBox(
                          height: mediaQuery.screenWidth(context, 1.4),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, index) {
                                return const SkeltonLoader(length: 5);
                              }),
                        );
                      }
                      if (value.isSuccessTv && value.listTv.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: mediaQuery.screenWidth(context, 1.4),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.listTv.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                        movie_id: value
                                                            .listRecommendation[
                                                                index]
                                                            .id
                                                            .toString(),
                                                      ))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              value.listTv[index].posterPath !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl: baseApi
                                                              .base_url_image +
                                                          value.listTv[index]
                                                              .posterPath
                                                              .toString(),
                                                      placeholder: (context,
                                                              url) =>
                                                          const Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                          url, error) {
                                                        if (value.listTv[index]
                                                                .posterPath ==
                                                            null) {
                                                          return const Icon(
                                                              Icons.error);
                                                        } else {
                                                          return const Icon(
                                                              Icons.error);
                                                        }
                                                      },
                                                      fit: BoxFit.fill,
                                                      width: mediaQuery
                                                          .screenWidth(
                                                              context, 2.5),
                                                      height: mediaQuery
                                                          .screenHeight(
                                                              context, 1.8),
                                                    )
                                                  : Image(
                                                      width: mediaQuery
                                                          .screenWidth(
                                                              context, 2.5),
                                                      height: mediaQuery
                                                          .screenHeight(
                                                              context, 1.8),
                                                      image: const AssetImage(
                                                          baseImage
                                                              .emptyImage)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20.0),
                                                      child: SizedBox(
                                                        width: mediaQuery
                                                            .screenWidth(
                                                                context, 5),
                                                        child: Text(
                                                          value.listTv[index]
                                                              .name
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    RatingBar(
                                                      itemSize: 16,
                                                      onRatingUpdate:
                                                          (value) {},
                                                      ratingWidget:
                                                          RatingWidget(
                                                              full: const Icon(
                                                                Icons.star,
                                                                color: baseColors
                                                                    .colorStar,
                                                              ),
                                                              half: const Icon(
                                                                Icons
                                                                    .star_border_outlined,
                                                                color: baseColors
                                                                    .colorStar,
                                                              ),
                                                              empty: const Icon(
                                                                  Icons
                                                                      .star_border_outlined)),
                                                      minRating: 1,
                                                      maxRating: 5,
                                                      initialRating: value
                                                              .listTv[index]
                                                              .voteAverage!
                                                              .toInt() /
                                                          2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  value.listPopular[index]
                                                      .releaseDate
                                                      .toString()
                                                      .characters
                                                      .take(4)
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }

                      return const Text('Failed');
                    }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 20),
                    child: Text(
                      'Popular People',
                      style: TextStyle(
                          fontSize: baseDimens.fontSize24,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    color: baseColors.colorPrimary,
                    child: Consumer<MovieProvider>(
                        builder: (context, value, child) {
                      if (value.isLoadingPopular) {
                        return SizedBox(
                          height: mediaQuery.screenHeight(context, 3),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, index) {
                                return const SkeltonLoaderCircle(length: 5);
                              }),
                        );
                      }
                      if (value.isSuccessTv && value.listTv.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: mediaQuery.screenHeight(context, 3),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.listPeople.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: GestureDetector(
                                          onTap: () => null,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              value.listPeople[index]
                                                          .profilePath !=
                                                      null
                                                  ? CircleAvatar(
                                                      radius:
                                                          48, // Image radius
                                                      backgroundImage:
                                                          NetworkImage(baseApi
                                                                  .base_url_image +
                                                              value
                                                                  .listPeople[
                                                                      index]
                                                                  .profilePath
                                                                  .toString()),
                                                    )
                                                  : const Image(
                                                      width: 100,
                                                      height: 100,
                                                      image: AssetImage(
                                                          baseImage
                                                              .emptyImage)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20.0),
                                                      child: SizedBox(
                                                        width: 130,
                                                        child: Text(
                                                          value
                                                              .listPeople[index]
                                                              .name
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  'vote: ${value.listPopular[index].voteCount.toString().characters.take(4)}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }
                      return const CircularProgressIndicator.adaptive();
                    }),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
