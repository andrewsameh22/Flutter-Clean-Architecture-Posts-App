import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error_handling/failure.dart';

class DeletePostUseCase {
  final PostsRepository postsRepository;

  DeletePostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call({required int id}) async {
    return await postsRepository.deletePost(id: id);
  }
}
