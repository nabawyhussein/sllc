import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sllc/features/post/domain/entities/post_entity.dart';

import '../../../../../global/errors/failures.dart';
import '../../../data/repos/post_repo_data_layer.dart';
import '../../../domain/usecases/add_post_use_case.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

part 'crud_posts_event.dart';
part 'crud_posts_state.dart';

class CrudPostsBloc extends Bloc<CrudPostsEvent, CrudPostsState> {
  final DeletePostUseCase deletePostUseCase;
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  CrudPostsBloc(
      {required this.deletePostUseCase,
      required this.addPostUseCase,
      required this.updatePostUseCase})
      : super(CrudPostsInitial()) {
    on<CrudPostsEvent>((event, emit) async {
      if (event is AddPostsEvent) {
        emit(LoadCrudPostsState());
        final addRes = await addPostUseCase.call(event.postEntity);
        emit(_result(addRes, "Post Added"));
      } else if (event is DeletePostsEvent) {
        emit(LoadCrudPostsState());
        final delRes = await deletePostUseCase.call(event.PostId);
        emit(_result(delRes, "Post Removed"));
      } else if (event is EditPostsEvent) {
        emit(LoadCrudPostsState());
        final updateRes = await updatePostUseCase.call(event.postEntity);
        emit(_result(updateRes, "Post Edited"));
      }
    });
  }

  CrudPostsState _result(Either<Failure, Unit> fold, String message) {
    return fold.fold(
      (fail) {
        return PostsCrudFailState(error: _knowFail(fail));
      },
      (added) {
        return PostsCrudSuccessState(successMessage: "Post Edited");
      },
    );
  }

  String _knowFail(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case OfflineFailure:
        return "OfflineFailure";
      default:
        return "Un Expected Error";
    }
  }
}
