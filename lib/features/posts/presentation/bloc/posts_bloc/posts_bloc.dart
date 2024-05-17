import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/core/error_handling/failure.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/get_all_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(PostsLoadingState());
        final failureOrPosts = await getAllPosts.call();
        failureOrPosts.fold(
          (failure) {
            emit(PostsErrorState(message: _mapFailureToMessage(failure)));
          },
          (posts) {
            emit(PostsLoadedState(posts: posts));
          },
        );
      } else if (event is RefreshPostsEvent) {}
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailureMessage";
      case EmptyCacheFailure:
        return "EmptyCacheFailureMessage";
      case OfflineFailure:
        return "OfflineFailureMessage";

      default:
        return "UnExpected Error, Please try again later.";
    }
  }
}
