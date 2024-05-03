import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error_handling/exceptions.dart';
import 'package:posts_app/core/error_handling/failure.dart';
import 'package:posts_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/networks/network_info.dart';
import '../datasources/posts_local_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(postModels: remotePosts);
        return right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost({required Post post}) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isDeviceConnected) {
      try {
        await remoteDataSource.addPost(
            post: postModel); // I am getting entity so converted to PostModel
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int id}) async {
    if (await networkInfo.isDeviceConnected) {
      try {
        await remoteDataSource.deletePost(id: id);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isDeviceConnected) {
      try {
        await remoteDataSource.updatePost(
            post: postModel); // I am getting entity so converted to PostModel
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
