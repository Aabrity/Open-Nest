import 'package:mocktail/mocktail.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends Mock implements LoginBloc {
  @override
  Stream<LoginState> get stream => Stream.empty(); // Mock the stream

  @override
  Future<void> close() async {} // Mock the close method
}