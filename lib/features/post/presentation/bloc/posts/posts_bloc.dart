import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sllc/features/post/domain/entities/post_entity.dart';
import 'package:sllc/features/post/domain/usecases/get_all_posts.dart';
import 'package:sllc/global/errors/failures.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(PostsLoadingState());
        final allPostsCallResults = await getAllPostsUseCase.call();
        allPostsCallResults.fold((fail) {
          emit(PostsFailState(error: _knowFail(fail)));
        }, (success) {
          emit(PostsLoadedState(allPosts: success));
        });
      }
    });
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
