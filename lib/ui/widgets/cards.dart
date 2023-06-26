import 'package:film_explorer/models/credit_movie_model.dart';
import 'package:film_explorer/models/list_movie_model.dart';
import 'package:film_explorer/models/review_movie_model.dart';
import 'package:film_explorer/models/trailer_movie_model.dart';
import 'package:film_explorer/shared/functions.dart';
import 'package:film_explorer/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/theme.dart';
import '../../shared/values.dart';

class TopMovieCard extends StatelessWidget {
  final Movie data;
  final int rank;
  const TopMovieCard({
    super.key,
    required this.data,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 145,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: grayColor,
        borderRadius: BorderRadius.circular(16),
        image: data.posterPath == null
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "$baseImageUrl/${data.posterPath}",
                ),
              ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.only(
            left: 15,
          ),
          child: Text(
            rank.toString(),
            style: whiteTextStyle.copyWith(
              fontSize: 70,
              fontWeight: semiBold,
              shadows: [
                Shadow(
                  color: backgroundBlackColor,
                  offset: const Offset(2, 5),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  const CategoryCard({
    super.key,
    required this.name,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: 90,
            height: 4,
            decoration: BoxDecoration(
              color: isSelected ? backgroundInput : backgroundColor,
            ),
          )
        ],
      ),
    );
  }
}

class ShimmerMovie extends StatelessWidget {
  const ShimmerMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: backgroundInput,
            highlightColor: grayColor,
            child: Container(
              height: 210,
              width: 145,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: grayColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: backgroundInput,
            highlightColor: grayColor,
            child: Container(
              height: 210,
              width: 145,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: grayColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: backgroundInput,
            highlightColor: grayColor,
            child: Container(
              height: 210,
              width: 145,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: grayColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerListHomeMovie extends StatelessWidget {
  const ShimmerListHomeMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: backgroundInput,
      highlightColor: grayColor,
      child: Container(
        decoration: BoxDecoration(
          color: grayColor,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class SearchCardMovie extends StatelessWidget {
  final Movie data;
  const SearchCardMovie({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
      ),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("$baseImageUrl/${data.posterPath}"),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 16,
                      color: orangColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      data.voteAverage.toString(),
                      style: orangTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: whiteColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      data.releaseDate == null ? "" : formatDate(data.releaseDate!),
                      style: whiteTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: whiteColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      data.popularity.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserReview extends StatelessWidget {
  final Review data;
  const UserReview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundInput,
                  image: data.authorDetails!.avatarPath == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("$baseImageUrl/${data.authorDetails!.avatarPath}"),
                        ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                data.authorDetails!.rating == null ? "no rate" : data.authorDetails!.rating.toString(),
                style: blueTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.authorDetails!.name.toString().isEmpty ? "No Name" : data.authorDetails!.name.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.content.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Cast extends StatelessWidget {
  final CastModel data;
  const Cast({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // print(data.profilePath);
    // print(data.profilePath == null);
    return Container(
      width: 75,
      height: 100,
      margin: const EdgeInsets.only(
        right: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (data.profilePath == null) ...[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: grayColor,
                shape: BoxShape.circle,
              ),
            ),
          ] else ...[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: orangColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("$baseImageUrl/${data.profilePath}"),
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 4,
          ),
          Text(
            data.name.toString(),
            style: whiteTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class CardGenre extends StatelessWidget {
  final String name;
  const CardGenre({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundInput,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Text(
        name,
        style: whiteTextStyle.copyWith(
          fontSize: 15,
          fontWeight: medium,
        ),
      ),
    );
  }
}

class TrailerMovieCard extends StatelessWidget {
  final TrailerMovieModel data;
  const TrailerMovieCard({
    super.key,
    required this.data,
  });

  String thumbnailUrl(key) {
    return 'https://img.youtube.com/vi/$key/mqdefault.jpg';
  }

  void openYouTubeApp(String key, BuildContext context) async {
    // final url = 'https://youtube.com/watch?v=$key';

    // if (!await launchUrl(Uri.parse(url))) {
    //   throw 'Tidak dapat membuka aplikasi YouTube.';
    // }
    Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerPlayer(keyVideo: key)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => openYouTubeApp(data.key.toString(), context),
      child: Container(
        height: 120,
        width: 240,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          // color: backgroundInput,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              thumbnailUrl(data.key),
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [backgroundBlackColor.withOpacity(0.2), backgroundBlackColor.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            backgroundBlendMode: BlendMode.colorBurn, // Mengatur mode blend untuk latar belakang
            // borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.5),
                blurRadius: 25.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.play_arrow_outlined,
                color: whiteColor,
                size: 35,
              ),
              Text(
                data.name.toString(),
                style: whiteTextStyle.copyWith(
                  shadows: shadow,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
