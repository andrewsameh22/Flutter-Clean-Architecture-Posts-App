import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

import '../../domain/entities/post_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost({required int id});
  Future<Unit> updatePost({required Post post});
  Future<Unit> addPost({required Post post});
}

class PostsRemoteImpl implements PostsRemoteDataSource {
  @override
  Future<Unit> addPost({required Post post}) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost({required int id}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost({required Post post}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
