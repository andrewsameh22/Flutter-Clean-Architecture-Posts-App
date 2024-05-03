import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

import '../../../../core/error_handling/failure.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost({required int id});
  Future<Either<Failure, Unit>> updatePost({required Post post});
  Future<Either<Failure, Unit>> addPost({required Post post});
}
