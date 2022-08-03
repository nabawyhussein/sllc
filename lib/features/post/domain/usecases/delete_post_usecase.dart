import 'package:dartz/dartz.dart';
import 'package:sllc/features/post/domain/repo/posts_repo_domain.dart';

import '../../../../global/errors/failures.dart';

class DeletePostUseCase {
  final PostsRepoDomain repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePostsById(postId);
  }
}
