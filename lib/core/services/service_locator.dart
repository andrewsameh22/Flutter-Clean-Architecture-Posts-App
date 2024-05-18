import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/networks/network_info.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/posts/data/datasources/posts_local_data_source.dart';
import '../../features/posts/data/datasources/posts_remote_data_source.dart';
import '../../features/posts/data/repositories/posts_repository_impl.dart';
import '../../features/posts/domain/repositories/posts_repository.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() async {
    // cubits

    sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
    sl.registerFactory(() => AddDeleteUpdatePostBloc(
          addPostUseCase: sl(),
          deletePostUseCase: sl(),
          updatePostUseCase: sl(),
        ));

    ///Use Cases
    sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));
    sl.registerLazySingleton(() => AddPostUseCase(postsRepository: sl()));
    sl.registerLazySingleton(() => UpdatePostUseCase(postsRepository: sl()));
    sl.registerLazySingleton(() => DeletePostUseCase(postsRepository: sl()));

    ///Repository
    sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
          remoteDataSource: sl(),
          localDataSource: sl(),
          networkInfo: sl(),
        ));

    ///Data Source
    sl.registerLazySingleton<PostsLocalDataSource>(
        () => PostsLocalDataSourceImpl(sharedPreferences: sl()));
    sl.registerLazySingleton<PostsRemoteDataSource>(() => PostsRemoteImpl());

    ///Core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    ///External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
