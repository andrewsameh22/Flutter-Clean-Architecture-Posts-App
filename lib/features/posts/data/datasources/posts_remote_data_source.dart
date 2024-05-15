import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

import '../../../../core/error_handling/exceptions.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/post_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost({required int id});
  Future<Unit> updatePost({required Post post});
  Future<Unit> addPost({required Post post});
}

class PostsRemoteImpl implements PostsRemoteDataSource {
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await Dio().get(AppConstants.getAllPostsPath);
    if (response.statusCode == 200) {
      return List<PostModel>.from(
          (response.data as List).map((e) => PostModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost({required Post post}) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response = await Dio().post(
      AppConstants.getAllPostsPath,
      data: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  /// comment for testing git reset commands
  @override
  Future<Unit> updatePost({required Post post}) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response = await Dio().patch(
      AppConstants.updateOrDeletePost(postId: post.id),
      data: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost({required int id}) async {
    final response = await Dio().delete(
      AppConstants.updateOrDeletePost(postId: id),
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
