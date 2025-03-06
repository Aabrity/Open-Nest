import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/features/auth/presentation/view/register_view.dart';
import 'package:open_nest/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MockRegisterBloc extends Mock implements RegisterBloc {
  @override
  Stream<RegisterState> get stream => Stream.empty(); // Mock the stream

  @override
  Future<void> close() async {} // Mock the close method
}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUpAll(() {
    registerFallbackValue(RegisterUserEvent(
      context: FakeBuildContext(), // Temporary placeholder
      username: 'user',
      password: 'user123',
      email: 'email@example.com',
      avatar: 'avatar.png',
    ));
    registerFallbackValue(UploadImage(file: File('path/to/image.png')));
  });

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
  });

  Widget wrapWithMaterialApp(Widget widget) {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>(
        create: (context) => mockRegisterBloc,
        child: widget,
      ),
    );
  }

  testWidgets('RegisterView renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterialApp(RegisterView()));

    expect(find.text('SIGN UP'), findsOneWidget);
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text("Let's take the first step, Create an account."), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Register'), findsOneWidget);
  });


  testWidgets('RegisterView navigates to image picker on avatar tap', (WidgetTester tester) async {
    when(() => mockRegisterBloc.add(any())).thenReturn(null);
    await tester.pumpWidget(wrapWithMaterialApp(RegisterView()));

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
  });
}

class FakeBuildContext extends Fake implements BuildContext {}