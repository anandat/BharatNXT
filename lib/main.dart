import 'package:bharatnxt/presentation/home/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/network/dio_client.dart';
import 'core/storage/favorites_storage.dart';
import 'data/repositories/article_repository.dart';
import 'presentation/home/bloc/home_bloc.dart';
import 'presentation/home/screens/home_screen.dart';

void main() {
  runApp(const ArticleApp());
}

class ArticleApp extends StatelessWidget {
  const ArticleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Article App',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: RepositoryProvider(
          create: (_) => ArticleRepository(DioClient().dio),
          child: BlocProvider(
            create: (context) => HomeBloc(
              repository: context.read<ArticleRepository>(),
              storage: FavoritesStorage(),
            )..add(LoadArticles()),
            child: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}
