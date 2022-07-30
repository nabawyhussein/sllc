import 'package:dartz/dartz.dart';
import 'package:sllc/features/post/domain/repo/posts_repo_domain.dart';

import '../../../../global/errors/failures.dart';
import '../entities/post_entity.dart';

class UpdatePostUseCase {
  final PostsRepoDomain repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PostEntity postEntity) async {
    return await repository.updatePostsById(postEntity);
  }
}