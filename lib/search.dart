import 'package:film_explorer/blocs/genre/genre_bloc.dart';
import 'package:film_explorer/blocs/search/search_movie_bloc.dart';
import 'package:film_explorer/detail.dart';
import 'package:film_explorer/models/list_movie_model.dart';
import 'package:film_explorer/shared/functions.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/ui/widgets/cards.dart';
import 'package:film_explorer/ui/widgets/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  final ScrollController controller;
  const Search({
    super.key,
    required this.controller,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController(text: '');
  FocusNode searchFocusNode = FocusNode();
  bool isSearch = false;
  late SearchMovieBloc _searchMovieBloc;
  late GenreBloc _genreBloc;
  List<Movie> _data = [];
  int _page = 0;
  int _totalPage = 1;

  @override
  void initState() {
    super.initState();
    // searchFocusNode.requestFocus();
    _searchMovieBloc = SearchMovieBloc();
    _genreBloc = GenreBloc()..add(GenreGet());
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            TextFormField(
              style: whiteTextStyle,
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundInput,
                hintText: 'Movie Name, Year released, and etc...',
                hintStyle: grayTextStyle,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: grayColor,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: grayColor,
                    width: 0,
                  ),
                ),
                suffixIcon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159), // Rotasi horizontal (180 derajat)
                  child: Icon(
                    Icons.search,
                    color: grayColor,
                    size: 24,
                  ),
                ),
              ),
              controller: searchController,
              onFieldSubmitted: (value) {
                _page = 0;
                _searchMovieBloc.add(SearchMovieGet(value, 1));
                setState(() {});
              },
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: widget.controller,
                child: BlocConsumer<SearchMovieBloc, SearchMovieState>(
                  bloc: _searchMovieBloc,
                  listener: (context, state) {
                    if (state is SearchMovieError) {
                      showCustomSnackbar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is SearchMovieLoading && _page == 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const ShimmerSearchCardMovie();
                        },
                      );
                    }

                    if (state is SearchMovieSuccess) {
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
                              child: (state is SearchMovieLoading)
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
                                        _searchMovieBloc.add(SearchMovieGetMore(searchController.text, _page + 1));
                                      },
                                    ),
                            ),
                          ]
                        ],
                      );
                    } else {
                      return emptyResult();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 144,
        ),
        Image.asset(
          "assets/icon_no_result.png",
          height: 100,
          width: 100,
        ),
        Text(
          "Start searching your favorite!",
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Find your movie by Type title,\ncategories, years, etc ",
          style: grayTextStyle.copyWith(
            fontSize: 12,
            fontWeight: medium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget emptyResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          "assets/icon_no_result.png",
          height: 100,
          width: 100,
        ),
        Text(
          "we are sorry, we can\nnot find the movie :(",
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Find your movie by Type title,\ncategories, years, etc ",
          style: grayTextStyle.copyWith(
            fontSize: 12,
            fontWeight: medium,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<GenreBloc, GenreState>(
          bloc: _genreBloc,
          listener: (context, state) {
            if (state is GenreFailed) {
              showCustomSnackbar(context, state.e);
            }
          },
          builder: (context, state) {
            return BlocBuilder<GenreBloc, GenreState>(
              bloc: _genreBloc,
              builder: (context, state) {
                if (state is GenreSuccess) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.data
                        .map(
                          (genre) => CardGenre(
                            data: genre,
                          ),
                        )
                        .toList(),
                  );
                }
                return Container();
              },
            );
          },
        )
      ],
    );
  }
}
