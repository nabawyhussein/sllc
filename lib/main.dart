import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/post/presentation/bloc/crud_post/crud_posts_bloc.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';
import 'features/post/presentation/screens/posts_screen.dart';
import 'injection.dart'as db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await db.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>db.sl<PostsBloc>()..add(GetAllPostsEvent())),
      BlocProvider(create: (_)=>db.sl<CrudPostsBloc>()),
    ], child:
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const PostsPage(),
    )
    );
  }
}

