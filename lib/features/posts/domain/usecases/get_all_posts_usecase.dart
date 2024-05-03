import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/failure.dart';
import '../entities/post_entity.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository postsRepository;

  GetAllPostsUseCase({required this.postsRepository});

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
