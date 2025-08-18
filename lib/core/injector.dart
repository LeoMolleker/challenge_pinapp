import 'package:challenge_pinapp/data/data_sources/interfaces/i_comments_remote_data_source.dart';
import 'package:challenge_pinapp/domain/repositories/i_comments_repository.dart';
import 'package:challenge_pinapp/domain/repositories/i_post_repository.dart';
import 'package:challenge_pinapp/domain/use_cases/get_post_comments_use_case.dart';
import 'package:challenge_pinapp/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:comments_plugin/comments_plugin.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/data_sources/interfaces/i_posts_local_data_source.dart';
import '../data/data_sources/locaL_data_sources/posts_local_data_source.dart';
import '../data/data_sources/remote_data_sources/comments_remote_data_source.dart';
import '../data/data_sources/remote_data_sources/post_remote_data_source.dart';
import '../data/repositories/comments_repository.dart';
import '../data/repositories/post_repository.dart';
import '../data/data_sources/interfaces/i_post_remote_data_source.dart';
import '../domain/use_cases/like_comment_use_case.dart';
import '../presentation/controllers/detail/detail_bloc_controller.dart';

abstract class Injector {
  static T get<T extends Object>() => GetIt.I<T>();

  static Future<void> setUp() async {
    //Dio
    GetIt.I.registerLazySingleton<Dio>(
      () {
        final dio = Dio(
          BaseOptions(
            baseUrl: 'https://jsonplaceholder.typicode.com',
            connectTimeout: Duration(seconds: 15),
          ),
        );

        dio.options.headers = {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
        };

        return dio;
      }
    );

    //Database
    final database = await openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, likes INTEGER)',
        );
      },
      version: 1,
    );
    GetIt.I.registerLazySingleton<Database>(() => database);

    //Plugins
    GetIt.I.registerLazySingleton<CommentsPlugin>(() => CommentsPlugin());

    //Local data sources
    GetIt.I.registerLazySingleton<IPostsLocalDataSource>(
      () => PostsLocalDataSource(GetIt.I<Database>()),
    );

    //Remote data sources
    GetIt.I.registerLazySingleton<IPostRemoteDataSource>(
      () => PostRemoteDataSource(GetIt.I<Dio>()),
    );
    GetIt.I.registerLazySingleton<ICommentsRemoteDataSource>(
      () => CommentsRemoteDataSource(GetIt.I<CommentsPlugin>()),
    );

    //Repositories
    GetIt.I.registerLazySingleton<IPostRepository>(
      () => PostRepository(
        postRemoteDataSource: GetIt.I<IPostRemoteDataSource>(),
        postsLocalDataSource: GetIt.I<IPostsLocalDataSource>(),
      ),
    );
    GetIt.I.registerLazySingleton<ICommentsRepository>(
      () => CommentsRepository(GetIt.I<ICommentsRemoteDataSource>()),
    );

    //Use cases
    GetIt.I.registerLazySingleton<GetPostUseCase>(
      () => GetPostUseCase(GetIt.I<IPostRepository>()),
    );
    GetIt.I.registerLazySingleton<GetPostCommentsUseCase>(
      () => GetPostCommentsUseCase(GetIt.I<ICommentsRepository>()),
    );
    GetIt.I.registerLazySingleton<LikeCommentUseCase>(
      () => LikeCommentUseCase(GetIt.I<IPostRepository>()),
    );

    //Blocs
    GetIt.I.registerLazySingleton<HomeBloc>(
      () => HomeBloc(GetIt.I<GetPostUseCase>()),
    );
    GetIt.I.registerFactory<DetailBloc>(
      () => DetailBloc(
        getPostCommentsUseCase: GetIt.I<GetPostCommentsUseCase>(),
        likeCommentUseCase: GetIt.I<LikeCommentUseCase>(),
      ),
    );
  }
}
