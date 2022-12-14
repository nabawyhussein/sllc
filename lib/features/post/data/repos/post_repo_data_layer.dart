import 'package:dartz/dartz.dart';
import 'package:sllc/features/post/data/models/post_model_data_layer.dart';
import 'package:sllc/features/post/data/sources/post_local_data_source.dart';
import 'package:sllc/features/post/data/sources/post_remote_data_source.dart';
import 'package:sllc/features/post/domain/entities/post_entity.dart';
import 'package:sllc/features/post/domain/repo/posts_repo_domain.dart';
import 'package:sllc/global/errors/exeptions.dart';
import 'package:sllc/global/errors/failures.dart';
import 'package:sllc/global/network/check_connection.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepoImpl implements PostsRepoDomain {
  final PostLocalDataSource postLocalDataSource;
  final PostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;
  PostRepoImpl(
      {required this.postRemoteDataSource,
      required this.postLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final allRemotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(allRemotePosts);
        return Right(allRemotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on OfflineException {
        return Left(EmptyCacheFailure());
      }
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> createPosts(PostEntity postEntity) async {
    PostModelDataLayer postModelDataLayer = PostModelDataLayer(
        id: postEntity.id, title: postEntity.title, body: postEntity.body);
    return await callMethod(() {
      return postRemoteDataSource.addPost(postModelDataLayer);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePostsById(PostEntity postEntity) async {
    PostModelDataLayer postModelDataLayer = PostModelDataLayer(
        id: postEntity.id, title: postEntity.title, body: postEntity.body);

    return await callMethod(() {
      return postRemoteDataSource.updatePost(postModelDataLayer);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePostsById(int postId) async {
    return await callMethod(() {
      return postRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, PostEntity>> getPostsById(int postId) {
    // TODO: implement getPostsById
    throw UnimplementedError();
  }

  Future<Either<Failure, Unit>> callMethod(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
