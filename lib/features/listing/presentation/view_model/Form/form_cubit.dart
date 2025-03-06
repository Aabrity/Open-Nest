import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:open_nest/features/listing/presentation/view_model/Form/form_state.dart';

class ContactFormCubit extends Cubit<ContactFormState> {
  ContactFormCubit() : super(const ContactFormState());

  void messageChanged(String message) {
    emit(state.copyWith(message: message));
  }

  Future<void> sendEmail(String landlordEmail) async {
    if (state.message.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter a message'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, isSuccess: false, errorMessage: null));

    final email = Email(
      body: state.message,
      subject: 'Regarding Your Listing',
      recipients: [landlordEmail],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (error) {
      emit(state.copyWith(isSubmitting: false, errorMessage: 'Failed to send email: $error'));
    }
  }

  void resetForm() {
    emit(const ContactFormState());
  }
}
