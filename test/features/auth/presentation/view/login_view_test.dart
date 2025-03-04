import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/features/auth/presentation/view/login_view.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends Mock implements LoginBloc {
  @override
  Stream<LoginState> get stream => Stream.empty(); // Mock the stream

  @override
  Future<void> close() async {} // Mock the close method
}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUpAll(() {
    registerFallbackValue(LoginStudentEvent(
      context: FakeBuildContext(), // Temporary placeholder
      username: 'dummy',
      password: 'dummy',
    ));
    registerFallbackValue(NavigateRegisterScreenEvent(
      destination: LoginView(),
      context: FakeBuildContext(),
    ));
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  Widget wrapWithMaterialApp(Widget widget) {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (context) => mockLoginBloc,
        child: widget,
      ),
    );
  }

  testWidgets('LoginView renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(LoginView()));

    expect(find.text('SIGN IN'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Sign in to your account.'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text("Don't have an account? "), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('LoginView shows validation errors for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(LoginView()));
     await tester.enterText(find.byType(TextFormField).at(0), '');
    await tester.enterText(find.byType(TextFormField).at(1), '');
    await tester.tap(find.text('Sign In'));
    await tester.pump();

    expect(find.text('Please enter username'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
  });

  testWidgets('LoginView calls LoginBloc on valid form submission', (WidgetTester tester) async {
    when(() => mockLoginBloc.add(any())).thenReturn(null);
    await tester.pumpWidget(wrapWithMaterialApp(LoginView()));

    final context = tester.element(find.byType(LoginView));

    await tester.enterText(find.byType(TextFormField).at(0), 'user');
    await tester.enterText(find.byType(TextFormField).at(1), 'user123');
    await tester.tap(find.text('Sign In'));
    await tester.pump();

    verify(() => mockLoginBloc.add(
          LoginStudentEvent(
            context: context,
            username: 'user',
            password: 'user123',
          ),
        ))
        .called(1);
  });

  testWidgets('LoginView navigates to RegisterView on Register tap', (WidgetTester tester) async {
    when(() => mockLoginBloc.add(any())).thenReturn(null);
    await tester.pumpWidget(wrapWithMaterialApp(LoginView()));

    final context = tester.element(find.byType(LoginView));

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    verify(() => mockLoginBloc.add(
          NavigateRegisterScreenEvent(
            destination: LoginView(),
            context: context,
          ),
        ))
        .called(1);
  });
}

class FakeBuildContext extends Fake implements BuildContext {}
