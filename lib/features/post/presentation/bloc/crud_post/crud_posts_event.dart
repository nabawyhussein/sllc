part of 'crud_posts_bloc.dart';

@immutable
abstract class CrudPostsEvent {}

class EditPostsEvent extends CrudPostsEvent {
  PostEntity postEntity;
  EditPostsEvent({required this.postEntity});
  @override
  List<Object?> get props => [postEntity];
}

class AddPostsEvent extends CrudPostsEvent {
  PostEntity postEntity;
  AddPostsEvent({required this.postEntity});
  @override
  List<Object?> get props => [postEntity];
}

class DeletePostsEvent extends CrudPostsEvent {
  int PostId;
  DeletePostsEvent({required this.PostId});
  @override
  List<Object?> get props => [PostId];
}

class FailCrudPostsEvent extends CrudPostsEvent {}
