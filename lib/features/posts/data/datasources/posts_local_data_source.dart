import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts({required List<PostModel> postModels});
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<Unit> cachePosts({required List<PostModel> postModels}) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}
