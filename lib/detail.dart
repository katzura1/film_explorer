import 'package:film_explorer/blocs/detail_movie/detail_movie_bloc.dart';
import 'package:film_explorer/shared/functions.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/shared/values.dart';
import 'package:film_explorer/ui/widgets/cards.dart';
import 'package:film_explorer/ui/widgets/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detail extends StatefulWidget {
  final int id;
  const Detail({
    super.key,
    required this.id,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int selectedIndex = 0;
  late DetailMovieBloc _detailMovieBloc;

  @override
  void initState() {
    super.initState();
    // print(widget.id);
    _detailMovieBloc = DetailMovieBloc()..add(DetailMovieGet(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          IconButton(
            onPressed: () {
              showCustomSnackbar(context, "Not working yet");
            },
            icon: const Icon(
              Icons.bookmark_outline,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _detailMovieBloc.add(DetailMovieGet(widget.id)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            movieHeader(),
            movieSummary(),
            movieTrailer(),
            movieGenre(),
            movieCast(),
            movieRecomendation(),
          ],
        ),
      ),
    );
  }

  Widget movieHeader() {
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      bloc: _detailMovieBloc,
      listener: (context, state) {
        if (state is DetailMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is DetailMovieLoading) {
          return Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grayColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 24,
                    width: 70,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundInput,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outline,
                          size: 16,
                          color: orangColor,
                        ),
                        Text(
                          "",
                          style: orangTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 160,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 120,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: whiteTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: semiBold,
                                  shadows: shadow,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icon_year.png",
                                        height: 16,
                                        width: 16,
                                        color: grayColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "",
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: medium,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: 16,
                                    width: 1,
                                    decoration: BoxDecoration(
                                      color: grayColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icon_duration.png",
                                        height: 16,
                                        width: 16,
                                        color: grayColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "",
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: medium,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }
        if (state is DetailMovieSuccess) {
          return Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  image: state.detail.backdropPath == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("$baseImageCoverUrl/${state.detail.backdropPath}"),
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 160,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 120,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: orangColor,
                            image: state.detail.posterPath == null
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("$baseImageUrl/${state.detail.posterPath}"),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.detail.title.toString(),
                                style: whiteTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: semiBold,
                                  shadows: shadow,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icon_year.png",
                                        height: 16,
                                        width: 16,
                                        color: grayColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        state.detail.releaseDate == null ? "" : formatDate(state.detail.releaseDate!),
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: medium,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 16,
                                    width: 1,
                                    decoration: BoxDecoration(
                                      color: grayColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icon_duration.png",
                                        height: 16,
                                        width: 16,
                                        color: grayColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${state.detail.runtime} Minutes",
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: medium,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 16,
                                    width: 1,
                                    decoration: BoxDecoration(
                                      color: grayColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star_outline,
                                        size: 16,
                                        color: grayColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${state.detail.voteAverage!}",
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget movieSummary() {
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      bloc: _detailMovieBloc,
      listener: (context, state) {
        if (state is DetailMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is DetailMovieLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CategoryCard(
                        name: "About Movie",
                        isSelected: true,
                        // isSelected: true,
                      ),
                      CategoryCard(
                        name: "Reviews",
                        isSelected: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const ShimmerParagraph(),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: grayColor,
                      borderRadius: BorderRadius.circular(
                        60,
                      )),
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_outlined,
                          color: whiteColor,
                          size: 22,
                        ),
                        Text(
                          "",
                          style: whiteTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        }
        if (state is DetailMovieSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: CategoryCard(
                          name: "About Movie",
                          isSelected: selectedIndex == 0,
                          // isSelected: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: CategoryCard(name: "Reviews", isSelected: selectedIndex == 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                if (selectedIndex == 0) ...[
                  Text(
                    state.detail.overview.toString(),
                    style: whiteTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ] else ...[
                  if (state.review.results!.isNotEmpty) ...[
                    Column(
                      children: state.review.results!.map((review) {
                        return UserReview(
                          data: review,
                        );
                      }).toList(),
                    ),
                  ] else ...[
                    Center(
                      child: Text(
                        "No review available.",
                        style: whiteTextStyle,
                      ),
                    )
                  ]
                ],
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget movieTrailer() {
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      bloc: _detailMovieBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DetailMovieSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Trailer",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state.trailer.isNotEmpty) ...[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: state.trailer.map((item) => TrailerMovieCard(data: item)).toList(),
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      "No Trailer available.",
                      style: whiteTextStyle,
                    ),
                  ),
                ]
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget movieCast() {
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      bloc: _detailMovieBloc,
      listener: (context, state) {
        if (state is DetailMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is DetailMovieSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Cast",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state.credit.cast!.isNotEmpty) ...[
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.credit.cast!
                          .map(
                            (cast) => Cast(
                              data: cast,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      "No Cast available.",
                      style: whiteTextStyle,
                    ),
                  ),
                ]
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget movieGenre() {
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      bloc: _detailMovieBloc,
      listener: (context, state) {
        if (state is DetailMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is DetailMovieSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Genre",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state.detail.genres!.isNotEmpty) ...[
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: state.detail.genres!.map((genre) => CardGenre(name: genre.name.toString())).toList(),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      "No genre available.",
                      style: whiteTextStyle,
                    ),
                  ),
                ]
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget movieRecomendation() {
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      bloc: _detailMovieBloc,
      listener: (context, state) {
        if (state is DetailMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is DetailMovieSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "You may also like this",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state.recomendation.results!.isNotEmpty) ...[
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.recomendation.results!
                          .map(
                            (movie) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detail(
                                      id: movie.id!,
                                    ),
                                  ),
                                );
                              },
                              child: TopMovieCard(
                                data: movie,
                                rank: state.recomendation.results!.indexOf(movie) + 1,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    // child: ShimmerMovie(),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      "No recomendation available.",
                      style: whiteTextStyle,
                    ),
                  ),
                ],
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
