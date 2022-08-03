part of 'crud_posts_bloc.dart';

@immutable
abstract class CrudPostsState {}

class CrudPostsInitial extends CrudPostsState {}

class PostsCrudSuccessState extends CrudPostsState {
  final String successMessage;
  PostsCrudSuccessState({required this.successMessage});
  @override
  List<Object?> get props => [successMessage];
}

class LoadCrudPostsState extends CrudPostsState {}

class PostsCrudFailState extends CrudPostsState {
  final String error;
  PostsCrudFailState({required this.error});
  @override
  List<Object?> get props => [error];
}
