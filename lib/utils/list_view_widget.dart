import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tmdb_movie/base/base_api.dart' as baseApi;
import 'package:tmdb_movie/base/base_colors.dart' as baseColors;
import 'package:tmdb_movie/utils/media_query.dart';

import '../data/model/movies_response.dart';
import '../pages/detail_page.dart';

class ListWidget extends StatefulWidget {
  ListWidget({super.key, required this.response});

  List<Results> response;
  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  AdjustScreen mediaQuery = AdjustScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.response.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              movie_id: widget.response[index].id.toString(),
                            ))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: baseApi.base_url_image +
                          widget.response[index].posterPath.toString(),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fill,
                      width: mediaQuery.screenWidth(context, 2.5),
                      height: mediaQuery.screenHeight(context, 1.8),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SizedBox(
                              width: mediaQuery.screenWidth(context, 5),
                              child: Text(
                                widget.response[index].title.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
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
                                empty: const Icon(Icons.star_border_outlined)),
                            minRating: 1,
                            maxRating: 5,
                            initialRating:
                                widget.response[index].voteAverage!.toInt() / 2,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.response[index].releaseDate
                            .toString()
                            .characters
                            .take(4)
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
