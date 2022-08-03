import 'package:dartz/dartz.dart';
import 'package:sllc/features/post/domain/entities/post_entity.dart';
import 'package:sllc/global/errors/failures.dart';

abstract class PostsRepoDomain {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, PostEntity>> getPostsById(int postId);
  Future<Either<Failure, Unit>> updatePostsById(PostEntity postEntity);
  Future<Either<Failure, Unit>> deletePostsById(int postId);
  Future<Either<Failure, Unit>> createPosts(PostEntity postEntity);
}
