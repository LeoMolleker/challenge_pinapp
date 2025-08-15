import 'package:challenge_pinapp/data/data_sources/interfaces/i_comments_remote_data_source.dart';
import 'package:challenge_pinapp/domain/repositories/i_comments_repository.dart';
import 'package:challenge_pinapp/domain/repositories/i_post_repository.dart';
import 'package:challenge_pinapp/domain/use_cases/get_post_comments_use_case.dart';
import 'package:challenge_pinapp/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:comments_plugin/comments_plugin.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/data_sources/remote_data_sources/comments_remote_data_source.dart';
import '../data/data_sources/remote_data_sources/post_remote_data_source.dart';
import '../data/repositories/comments_repository.dart';
import '../data/repositories/post_repository.dart';
import '../data/data_sources/interfaces/i_post_remote_data_source.dart';
import '../presentation/controllers/detail/detail_bloc_controller.dart';

abstract class Injector {

  static T get<T extends Object>() => GetIt.I<T>();

  static void setUp() {
    final getIt = GetIt.I;
    getIt.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: Duration(seconds: 15),
        ),
      ),
    );
    getIt.registerLazySingleton<CommentsPlugin>(
          () => CommentsPlugin(),
    );
    getIt.registerLazySingleton<IPostRemoteDataSource>(
      () => PostRemoteDataSource(getIt<Dio>()),
    );
    getIt.registerLazySingleton<ICommentsRemoteDataSource>(
          () => CommentsRemoteDataSource(getIt<CommentsPlugin>()),
    );
    getIt.registerLazySingleton<IPostRepository>(
      () => PostRepository(getIt<IPostRemoteDataSource>()),
    );
    getIt.registerLazySingleton<ICommentsRepository>(
          () => CommentsRepository(getIt<ICommentsRemoteDataSource>()),
    );
    getIt.registerFactory<GetPostUseCase>(
      () => GetPostUseCase(getIt<IPostRepository>()),
    );
    getIt.registerFactory<GetPostCommentsUseCase>(
          () => GetPostCommentsUseCase(getIt<ICommentsRepository>()),
    );
    getIt.registerFactory<HomeBloc>(
      () => HomeBloc(getIt<GetPostUseCase>()),
    );
    getIt.registerFactory<DetailBloc>(
          () => DetailBloc(getIt<GetPostCommentsUseCase>()),
    );
  }
}
