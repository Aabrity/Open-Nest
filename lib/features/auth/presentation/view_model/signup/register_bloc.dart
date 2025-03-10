import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
import 'package:open_nest/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:open_nest/features/auth/domain/use_case/upload_image_usecase.dart';



part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc( {
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  }) :
        _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);


  }



  void _onRegisterEvent(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      username: event.username,
      email: event.email,
      password: event.password,
      avatar: state.avatarName,
    ));

    result.fold(
      (l) { 
        emit(state.copyWith(isLoading: false, isSuccess: false));
        if (l.message == "Exception: Exception: Created") {
          showMySnackBar(
            context: event.context,
            message: "Registration Successful",
          );
        } else {
          showMySnackBar(
            context: event.context,
            message: l.message,
            color: Colors.red,
          );
        }
      },
      (r) { 
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  }





  void _onLoadImage(
  UploadImage event,
  Emitter<RegisterState> emit,
) async {
  emit(state.copyWith(isLoading: true));

  final result = await _uploadImageUsecase.call(
    UploadImageParams(file: event.file),
  );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, avatarName: r));
      },
    );
  }
}

