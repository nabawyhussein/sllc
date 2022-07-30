import 'package:dartz/dartz.dart';
import 'package:rabieaomran/features/post/data/models/post_model_data_layer.dart';
import 'package:rabieaomran/features/post/domain/entities/post_entity.dart';
import 'package:rabieaomran/features/post/domain/repo/posts_repo_domain.dart';
import 'package:rabieaomran/global/errors/failures.dart';

class PostRepoImpl implements PostsRepoDomain{
  @override
  Future<Either<Failure, Unit>> createPosts(PostEntity postEntity) {
    // TODO: implement createPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePostsById(int postId) {
    // TODO: implement deletePostsById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> getPostsById(int postId) {
    // TODO: implement getPostsById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePostsById(PostEntity postEntity) {
    // TODO: implement updatePostsById
    throw UnimplementedError();
  }

}