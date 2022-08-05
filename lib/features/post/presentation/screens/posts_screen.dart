
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts/posts_bloc.dart';
import '../widgets/posts_screen_widgets/message_widget.dart';
import '../widgets/posts_screen_widgets/posts_builder_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is PostsLoadedState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(posts: state.allPosts));
          } else if (state is PostsFailState) {
            return MessageDisplayWidget(message: state.error);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => PostAddUpdatePage(
        //           isUpdatePost: false,
        //         )));
      },
      child: const Icon(Icons.add),
    );
  }
}