import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error_handling/failure.dart';
import '../entities/post_entity.dart';

class UpdatePostUseCase {
  final PostsRepository postsRepository;

  UpdatePostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call({required Post post}) async {
    return await postsRepository.updatePost(post: post);
  }
}
