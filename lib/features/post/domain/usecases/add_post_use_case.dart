import 'package:dartz/dartz.dart';
import 'package:sllc/features/post/domain/entities/post_entity.dart';
import 'package:sllc/features/post/domain/repo/posts_repo_domain.dart';

import '../../../../global/errors/failures.dart';

class AddPostUseCase {
  final PostsRepoDomain repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await repository.createPosts(post);
  }
}
