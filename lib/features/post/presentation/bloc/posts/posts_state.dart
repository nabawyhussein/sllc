part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<PostEntity> allPosts;
  PostsLoadedState({required this.allPosts});
  @override
  List<Object?> get props => [allPosts];
}

class PostsFailState extends PostsState {
  final String error;
  PostsFailState({required this.error});
  @override
  List<Object?> get props => [error];
}
