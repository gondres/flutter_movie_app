import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tmdb_movie/base/base_api.dart' as baseApi;
import 'package:tmdb_movie/base/base_colors.dart' as baseColors;
import 'package:tmdb_movie/base/base_image.dart' as baseImage;
import 'package:tmdb_movie/pages/home_page.dart';
import '../database/database_helper.dart';
import '../database/model/watch_later_model.dart';
import 'detail_page.dart';

class WatchLaterPage extends StatefulWidget {
  const WatchLaterPage({super.key});

  @override
  State<WatchLaterPage> createState() => _WatchLaterPageState();
}

class _WatchLaterPageState extends State<WatchLaterPage> {
  List<WatchLater> listWatchLater = [];

  @override
  void initState() {
    // TODO: implement initState
    _loadWatchLater();
    super.initState();
  }

  Future<List<WatchLater>> _loadWatchLater() async {
    List<Map<String, dynamic>> results =
        await DatabaseHelper.instance.queryAllRows();
    setState(() {
      listWatchLater = results.map((item) => WatchLater.fromMap(item)).toList();
    });
    if (listWatchLater.isNotEmpty) {
      for (var element in listWatchLater) {
        debugPrint('DATABASE${element.title}');
      }
    }
    return listWatchLater =
        results.map((item) => WatchLater.fromMap(item)).toList();
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
          'Watch Later',
          style: TextStyle(color: baseColors.colorSecondary),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image(
              image: AssetImage(baseImage.appLogo),
              width: 200,
              height: 100,
            ),
          )
        ],
      ),
      body: listWatchLater.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: List.generate(
                        listWatchLater.length,
                        (index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            movie_id: listWatchLater[index]
                                                .id
                                                .toString(),
                                          ))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: baseApi.base_url_image +
                                          listWatchLater[index]
                                              .imageUrl
                                              .toString(),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.fill,
                                      width: 250,
                                      height: 200,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: SizedBox(
                                            width: 130,
                                            child: Text(
                                              listWatchLater[index]
                                                  .title
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        RatingBar(
                                          itemSize: 16,
                                          onRatingUpdate: (value) {},
                                          ratingWidget: RatingWidget(
                                              full: const Icon(
                                                Icons.star,
                                                color: baseColors.colorStar,
                                              ),
                                              half: const Icon(
                                                Icons.star_border_outlined,
                                                color: baseColors.colorStar,
                                              ),
                                              empty: const Icon(
                                                  Icons.star_border_outlined)),
                                          minRating: 1,
                                          maxRating: 5,
                                          initialRating: listWatchLater[index]
                                                  .rating
                                                  .toInt() /
                                              2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      listWatchLater[index]
                                          .date
                                          .toString()
                                          .characters
                                          .take(4)
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
              ),
            )
          : const Center(child: Text('No Watch Later Movies')),
    );
  }
}
