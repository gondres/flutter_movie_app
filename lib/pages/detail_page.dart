import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie/database/model/watch_later_model.dart';
import 'package:tmdb_movie/pages/home_page.dart';
import 'package:tmdb_movie/provider/movie_provider.dart';
import 'package:tmdb_movie/base/base_api.dart' as baseApi;
import 'package:tmdb_movie/base/base_colors.dart' as baseColors;
import 'package:tmdb_movie/base/base_image.dart' as baseImage;
import 'package:tmdb_movie/base/base_dimens.dart' as baseDimens;
import 'package:tmdb_movie/utils/media_query.dart';
import 'package:tmdb_movie/utils/skelton_loader.dart';

import '../database/database_helper.dart';
import '../utils/list_view_widget.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    super.key,
    required this.movie_id,
  });

  String movie_id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<WatchLater> listWatchLater = [];
  AdjustScreen mediaQuery = AdjustScreen();
  bool isAdded = false;
  @override
  void initState() {
    fetchDetail(widget.movie_id);
    checkWatchLater();
    super.initState();
  }

  Future<void> fetchDetail(String id) async {
    var provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getDetailMovie(id);
    await provider.getSimilar(id);
  }

  Future<bool> checkWatchLater() async {
    List<Map<String, dynamic>> results =
        await DatabaseHelper.instance.queryAllRows();
    setState(() {
      listWatchLater = results.map((item) => WatchLater.fromMap(item)).toList();
    });
    if (listWatchLater.isNotEmpty) {
      for (var element in listWatchLater) {
        debugPrint('check element ${element.id} id movie${widget.movie_id}');
        if (element.id.toString() == widget.movie_id) {
          debugPrint('check${element.id}${widget.movie_id}');
          setState(() {
            isAdded = true;
          });
        }
      }
    }
    return isAdded;
  }

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: "",
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: baseColors.colorPrimary,
          leading: GestureDetector(
            onTap: () => Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: baseColors.colorSecondary,
            ),
          ),
          title: const Text(
            'Detail Movies',
            style: TextStyle(color: baseColors.colorSecondary),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image(
                image: const AssetImage(baseImage.appLogo),
                width: mediaQuery.screenWidth(context, 3),
                height: mediaQuery.screenHeight(context, 3),
              ),
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(child: Consumer<MovieProvider>(
            builder: (context, value, child) {
              if (value.isSuccessDetail) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 450,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(baseApi.base_url_image +
                                  value.detail.backdropPath.toString()),
                              fit: BoxFit.fitWidth),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.detail.title.toString(),
                            style: const TextStyle(
                                fontSize: baseDimens.fontSize24,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              value.detail.releaseDate
                                  .toString()
                                  .characters
                                  .take(4)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text(
                              'Genre',
                              style: TextStyle(
                                  fontSize: baseDimens.fontSize24,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.detail.genres!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      value.detail.genres![index].name
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text(
                              'Overview',
                              style: TextStyle(
                                  fontSize: baseDimens.fontSize24,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 30),
                            child: Text(
                              value.detail.overview.toString(),
                              style: const TextStyle(
                                  fontSize: baseDimens.fontSize18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 30.0, bottom: 16),
                            child: Text(
                              'Production Companies',
                              style: TextStyle(
                                  fontSize: baseDimens.fontSize24,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  value.detail.productionCompanies!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 50.0),
                                  child: value
                                              .detail
                                              .productionCompanies![index]
                                              .logoPath !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: value
                                                      .detail
                                                      .productionCompanies![
                                                          index]
                                                      .logoPath !=
                                                  null
                                              ? baseApi.base_url_image +
                                                  value
                                                      .detail
                                                      .productionCompanies![
                                                          index]
                                                      .logoPath
                                                      .toString()
                                              : 'https://image.tmdb.org/t/p/w500//iKUwhA4DUxMcNKu5lLSbDFwwilk.jpg',
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) {
                                            if (error.statusCode == 404) {
                                              return const Icon(Icons.error);
                                            } else {
                                              return const Icon(Icons.error);
                                            }
                                          },
                                          fit: BoxFit.contain,
                                          width: 350,
                                          height: 250,
                                        )
                                      : null,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Divider(
                              color: baseColors.colorSecondary,
                              height: 5,
                              thickness: 2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Text(
                              'Similar Movies',
                              style: TextStyle(
                                  fontSize: baseDimens.fontSize24,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          if (value.isSuccesSimilar &&
                              value.listSimilar.isNotEmpty)
                            SizedBox(
                                height: 450,
                                child: ListWidget(
                                  response: value.listRecommendation,
                                )),
                          if (value.listSimilar.isEmpty)
                            SizedBox(
                              height: 450,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, index) {
                                    return const SkeltonLoader(length: 5);
                                  }),
                            ),
                          Center(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      baseColors.colorPrimary),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: const BorderSide(
                                          color: baseColors.colorPrimary,
                                          width: 0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (!isAdded) {
                                    var insert = WatchLater(
                                        id: value.detail.id,
                                        title: value.detail.title.toString(),
                                        imageUrl:
                                            value.detail.posterPath.toString(),
                                        rating: value.detail.voteAverage!,
                                        date: value.detail.releaseDate!,
                                        isChecked: true);
                                    await DatabaseHelper.instance
                                        .insert(insert.toMap());
                                    setState(() {
                                      isAdded = true;
                                    });
                                    showSnackBar(
                                        'Success add ${value.detail.title} to watch later list');
                                  } else {
                                    await DatabaseHelper.instance
                                        .delete(value.detail.id!.toInt());
                                    setState(() {
                                      isAdded = false;
                                    });
                                    showSnackBar(
                                        'Success delete ${value.detail.title} from watch later list');
                                  }
                                },
                                child: Text(
                                  isAdded
                                      ? 'Delete from watch later'
                                      : 'Add to watch later',
                                  style: const TextStyle(
                                      color: baseColors.colorSecondary),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator.adaptive());
            },
          )),
        ));
  }
}
