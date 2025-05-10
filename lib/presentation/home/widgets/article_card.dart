import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/article_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class ArticleCard extends StatefulWidget {
  final Article article;

  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  void didUpdateWidget(covariant ArticleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.article.isFavorite != widget.article.isFavorite) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          widget.article.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.article.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            widget.article.isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
            color: widget.article.isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(ToggleFavorite(widget.article.id));
          },
        ),
        onTap: () {

        },
      ),
    );
  }
}
