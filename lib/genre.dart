import 'package:film_explorer/blocs/genre_movie/genre_movie_bloc.dart';
import 'package:film_explorer/shared/functions.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/ui/widgets/cards.dart';
import 'package:film_explorer/ui/widgets/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail.dart';
import 'models/list_movie_model.dart';

class Genre extends StatefulWidget {
  final String title;
  final int id;
  const Genre({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  late GenreMovieBloc _genreMovieBloc;
  List<Movie> _data = [];
  int _page = 0;
  int _totalPage = 1;

  @override
  void initState() {
    super.initState();
    _genreMovieBloc = GenreMovieBloc()..add(GenreMovieGet(widget.id, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<GenreMovieBloc, GenreMovieState>(
          bloc: _genreMovieBloc,
          listener: (context, state) {
            if (state is GenreMovieError) {
              showCustomSnackbar(context, state.e);
            }
          },
          builder: (context, state) {
            if (state is GenreMovieLoading && _page == 0) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ShimmerSearchCardMovie();
                },
              );
            }

            if (state is GenreMovieSuccess) {
              _data = state.data.results!;
              _page = state.data.page!;
              _totalPage = state.data.totalPages!;
            }

            if (_data.isNotEmpty) {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                id: _data[index].id!,
                              ),
                            ),
                          );
                        },
                        child: SearchCardMovie(
                          data: _data[index],
                        ),
                      );
                    },
                  ),
                  if (_page < _totalPage) ...[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundBlackColor,
                        borderRadius: BorderRadius.circular(
                          60,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      child: (state is GenreMovieLoading)
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : TextButton(
                              child: Text(
                                "Load More",
                                style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                //for next time
                                _genreMovieBloc.add(GenreMovieGetMore(widget.id, _page + 1));
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
