import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/loading_indicator.dart';
import '../../../data/models/article_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  void _onSearch(String query) {
    _searchQuery = query;
    context.read<HomeBloc>().add(SearchArticles(query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          _onSearch(_searchQuery);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Articles')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search articles...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const LoadingIndicator();
                  } else if (state is HomeLoaded) {
                    final List<Article> visibleArticles = _selectedIndex == 0
                        ? state.articles
                        : state.articles.where((a) => a.isFavorite).toList();

                    if (visibleArticles.isEmpty) {
                      return const Center(child: Text('No articles found.'));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(LoadArticles());
                        _onSearch(_searchQuery);
                      },
                      child: ListView.builder(
                        itemCount: visibleArticles.length,
                        itemBuilder: (context, index) {
                          final article = visibleArticles[index];
                          return ArticleCard(
                            key: ValueKey(article.id),
                            article: article,
                          );
                        },
                      ),
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
