import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error_handling/failure.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/add_post_usecase.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPostUseCase.call(
          post: event.post,
        );
        failureOrDoneMessage.fold(
          (failure) {
            emit(ErrorAddDeleteUpdatePostState(
                message: _mapFailureToMessage(failure)));
          },
          (_) {
            emit(MessageAddDeleteUpdatePostState(message: 'success'));
          },
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePostUseCase.call(
          post: event.post,
        );
        failureOrDoneMessage.fold(
          (failure) {
            emit(ErrorAddDeleteUpdatePostState(
                message: _mapFailureToMessage(failure)));
          },
          (_) {
            emit(MessageAddDeleteUpdatePostState(message: 'success'));
          },
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePostUseCase.call(
          id: event.postId,
        );
        failureOrDoneMessage.fold(
          (failure) {
            emit(ErrorAddDeleteUpdatePostState(
                message: _mapFailureToMessage(failure)));
          },
          (_) {
            emit(MessageAddDeleteUpdatePostState(message: 'success'));
          },
        );
      }
    });
  }
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
