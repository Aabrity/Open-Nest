import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

// States
class ContactFormState extends Equatable {
  final String message;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const ContactFormState({
    this.message = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ContactFormState copyWith({
    String? message,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ContactFormState(
      message: message ?? this.message,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [message, isSubmitting, isSuccess, errorMessage];
}
