import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';

import 'core/services/service_locator.dart';
import 'features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<PostsBloc>()),
        BlocProvider(create: (context) => sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Hello'),
          ),
          body: Center(
            child: Text('World'),
          ),
        ),
      ),
    );
  }
}
