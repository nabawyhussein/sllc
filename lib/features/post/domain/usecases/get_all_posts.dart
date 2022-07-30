import 'package:dartz/dartz.dart';
import 'package:rabieaomran/features/post/domain/repo/posts_repo_domain.dart';

import '../../../../global/errors/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUseCase {
  final PostsRepoDomain repository;

  GetAllPostsUseCase(this.repository);

 Future <Either<Failure,List<PostEntity>>> call() async {
    return await repository.getAllPosts();
  }
}