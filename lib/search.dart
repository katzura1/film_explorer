import 'package:film_explorer/blocs/search/search_movie_bloc.dart';
import 'package:film_explorer/detail.dart';
import 'package:film_explorer/shared/functions.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/ui/widgets/cards.dart';
import 'package:film_explorer/ui/widgets/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController(text: '');
  FocusNode searchFocusNode = FocusNode();
  bool isSearch = false;
  late SearchMovieBloc _searchMovieBloc;

  @override
  void initState() {
    super.initState();
    // searchFocusNode.requestFocus();
    _searchMovieBloc = SearchMovieBloc();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(
          height: 16,
        ),
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
            _searchMovieBloc.add(SearchMovieGet(value));
          },
        ),
        BlocConsumer<SearchMovieBloc, SearchMovieState>(
          bloc: _searchMovieBloc,
          listener: (context, state) {
            if (state is SearchMovieError) {
              showCustomSnackbar(context, state.e);
            }
          },
          builder: (context, state) {
            if (state is SearchMovieLoading) {
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
              if (state.data.results!.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.data.results!.length,
                  itemBuilder: (context, index) {
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
                      child: SearchCardMovie(
                        data: state.data.results![index],
                      ),
                    );
                  },
                );
              } else {
                return emptyResult();
              }
            }
            return firstPage();
          },
        ),
      ],
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
          height: 144,
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
      ],
    );
  }
}
