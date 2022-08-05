import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sllc/features/post/data/repos/post_repo_data_layer.dart';
import 'package:sllc/features/post/domain/usecases/add_post_use_case.dart';

import 'features/post/data/sources/post_local_data_source.dart';
import 'features/post/data/sources/post_remote_data_source.dart';
import 'features/post/domain/repo/posts_repo_domain.dart';
import 'features/post/domain/usecases/delete_post_usecase.dart';
import 'features/post/domain/usecases/get_all_posts.dart';
import 'features/post/domain/usecases/update_post_usecase.dart';
import 'features/post/presentation/bloc/crud_post/crud_posts_bloc.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';
import 'global/network/check_connection.dart';

final sl = GetIt.instance;



Future<void> init() async {
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => CrudPostsBloc(
      addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCase: sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton<PostsRepoDomain>(() => PostRepoImpl(
      postLocalDataSource: sl(),
      postRemoteDataSource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
