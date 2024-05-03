import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error_handling/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts({required List<PostModel> postModels});
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts({required List<PostModel> postModels}) {
    List postModelsToJson = postModels.map((post) => post.toJson()).toList();
    sharedPreferences.setString("caches_posts", json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString("caches_posts");
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodedJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
