import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error_handling/failure.dart';
import '../entities/post_entity.dart';

class AddPostUseCase {
  final PostsRepository postsRepository;

  AddPostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call({required Post post}) async {
    return await postsRepository.addPost(post: post);
  }
}
