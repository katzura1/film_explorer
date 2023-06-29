import 'package:film_explorer/blocs/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:film_explorer/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:film_explorer/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:film_explorer/blocs/upcoming/upcoming_movie_bloc.dart';
import 'package:film_explorer/detail.dart';
import 'package:film_explorer/home.dart';
import 'package:film_explorer/shared/functions.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/shared/values.dart';
import 'package:film_explorer/ui/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late MovieBloc _movieBloc;
  late NowPlayingMovieBloc _nowPlayingMovieBloc;
  late TopRatedMovieBloc _topRatedMovieBloc;
  late UpcomingMovieBloc _upcomingMovieBloc;
  int selectedIndexTab = 0;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc()..add(MovieGet());
    _nowPlayingMovieBloc = NowPlayingMovieBloc()..add(NowPlayingMovieGet());
    _topRatedMovieBloc = TopRatedMovieBloc()..add(TopRatedMovieGet());
    _upcomingMovieBloc = UpcomingMovieBloc()..add(UpcomingMovieGet());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _movieBloc.add(MovieGet());
        _nowPlayingMovieBloc.add(NowPlayingMovieGet());
        _topRatedMovieBloc.add(TopRatedMovieGet());
        _upcomingMovieBloc.add(UpcomingMovieGet());
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(
            height: 42,
          ),
          Text(
            "What do you want to watch?",
            style: whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home(selectedIndex: 1)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: backgroundInput,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 11,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search",
                    style: grayTextStyle,
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159), // Rotasi horizontal (180 derajat)
                    child: Icon(
                      Icons.search,
                      color: grayColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocConsumer<MovieBloc, MovieState>(
            bloc: _movieBloc,
            listener: (context, state) {
              if (state is MovieError) {
                showCustomSnackbar(context, state.e);
              }
            },
            builder: (context, state) {
              if (state is MovieLoading) {
                return const ShimmerMovie();
              }
              if (state is MovieSuccess) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.data.results!.map((item) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                id: item.id!,
                              ),
                            ),
                          );
                        },
                        child: TopMovieCard(
                          data: item,
                          rank: state.data.results!.indexOf(item) + 1,
                        ),
                      );
                    }).toList(),
                  ),
                  // child: ShimmerMovie(),
                );
              }
              return Container();
            },
          ),
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
                      selectedIndexTab = 0;
                      _nowPlayingMovieBloc.add(NowPlayingMovieGet());
                    });
                  },
                  child: CategoryCard(
                    name: "Now Playing",
                    isSelected: selectedIndexTab == 0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexTab = 1;
                      _topRatedMovieBloc.add(TopRatedMovieGet());
                    });
                  },
                  child: CategoryCard(
                    name: "Top Rated",
                    isSelected: selectedIndexTab == 1,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexTab = 2;
                      _upcomingMovieBloc.add(UpcomingMovieGet());
                    });
                  },
                  child: CategoryCard(
                    name: "Upcoming",
                    isSelected: selectedIndexTab == 2,
                  ),
                ),
              ],
            ),
          ),
          if (selectedIndexTab == 0) ...[
            listNowPlaying(),
          ] else if (selectedIndexTab == 1) ...[
            listTopRated(),
          ] else if (selectedIndexTab == 2) ...[
            listUpcoming(),
          ]
        ],
      ),
    );
  }

  Widget listNowPlaying() {
    return BlocConsumer<NowPlayingMovieBloc, NowPlayingMovieState>(
      bloc: _nowPlayingMovieBloc,
      listener: (context, state) {
        if (state is NowPlayingMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is NowPlayingMovieLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 175,
              crossAxisCount: 3, // Jumlah item per baris
              crossAxisSpacing: 10.0, // Jarak horizontal antar item
              mainAxisSpacing: 10.0, // Jarak vertikal antar baris
            ),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return const ShimmerListHomeMovie();
            },
          );
        }

        if (state is NowPlayingMovieSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 175,
              crossAxisCount: 3, // Jumlah item per baris
              crossAxisSpacing: 10.0, // Jarak horizontal antar item
              mainAxisSpacing: 10.0, // Jarak vertikal antar baris
            ),
            itemCount: state.data.results!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(
                        id: state.data.results![index].id!,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: grayColor,
                    image: state.data.results![index].posterPath == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("$baseImageUrl/${state.data.results![index].posterPath}"),
                          ),
                  ),
                ),
              );
              // return ShimmerListHomeMovie();
            },
          );
        }

        return Container();
      },
    );
  }

  Widget listTopRated() {
    return BlocConsumer<TopRatedMovieBloc, TopRatedMovieState>(
      bloc: _topRatedMovieBloc,
      listener: (context, state) {
        if (state is TopRatedMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is TopRatedMovieLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 175,
              crossAxisCount: 3, // Jumlah item per baris
              crossAxisSpacing: 10.0, // Jarak horizontal antar item
              mainAxisSpacing: 10.0, // Jarak vertikal antar baris
            ),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return const ShimmerListHomeMovie();
            },
          );
        }

        if (state is TopRatedMovieSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 175,
              crossAxisCount: 3, // Jumlah item per baris
              crossAxisSpacing: 10.0, // Jarak horizontal antar item
              mainAxisSpacing: 10.0, // Jarak vertikal antar baris
            ),
            itemCount: state.data.results!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(
                        id: state.data.results![index].id!,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: grayColor,
                    image: state.data.results![index].posterPath == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("$baseImageUrl/${state.data.results![index].posterPath}"),
                          ),
                  ),
                ),
              );
              // return ShimmerListHomeMovie();
            },
          );
        }

        return Container();
      },
    );
  }

  Widget listUpcoming() {
    return BlocConsumer<UpcomingMovieBloc, UpcomingMovieState>(
      bloc: _upcomingMovieBloc,
      listener: (context, state) {
        if (state is UpcomingMovieError) {
          showCustomSnackbar(context, state.e);
        }
      },
      builder: (context, state) {
        if (state is UpcomingMovieLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 175,
              crossAxisCount: 3, // Jumlah item per baris
              crossAxisSpacing: 10.0, // Jarak horizontal antar item
              mainAxisSpacing: 10.0, // Jarak vertikal antar baris
            ),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return const ShimmerListHomeMovie();
            },
          );
        }

        if (state is UpcomingMovieSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 175,
              crossAxisCount: 3, // Jumlah item per baris
              crossAxisSpacing: 10.0, // Jarak horizontal antar item
              mainAxisSpacing: 10.0, // Jarak vertikal antar baris
            ),
            itemCount: state.data.results!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(
                        id: state.data.results![index].id!,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    // color: Colors.primaries[index % Colors.primaries.length],
                    color: grayColor,
                    image: state.data.results![index].posterPath == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("$baseImageUrl/${state.data.results![index].posterPath}"),
                          ),
                  ),
                ),
              );
              // return ShimmerListHomeMovie();
            },
          );
        }

        return Container();
      },
    );
  }
}
