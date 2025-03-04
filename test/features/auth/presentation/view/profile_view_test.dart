import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
// import 'package:open_nest/features/auth/presentation/view/profile_page.dart';
import 'package:open_nest/features/auth/presentation/view/profile_view.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

class MockUserBloc extends Mock implements UserBloc {
  @override
  Stream<UserState> get stream => Stream.empty(); // Mock the stream

  @override
  Future<void> close() async {} // Mock the close method
}

void main() {
  late MockUserBloc mockUserBloc;

  setUpAll(() {
    registerFallbackValue(FetchUserEvent());
    registerFallbackValue(UpdateUserEvent(UpdateUserParams(
      username: 'dummy',
      email: 'dummy@example.com',
      password: 'dummy',
      avatar: 'dummyBase64',
    )));
  });

  setUp(() {
    mockUserBloc = MockUserBloc();
  });

  Widget wrapWithMaterialApp(Widget widget) {
    return MaterialApp(
      home: BlocProvider<UserBloc>(
        create: (context) => mockUserBloc,
        child: widget,
      ),
    );
  }

  testWidgets('ProfilePage renders correctly', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserInitial());

    await tester.pumpWidget(wrapWithMaterialApp(ProfilePage()));

    expect(find.text('Profile'), findsOneWidget);
    
  });

  testWidgets('ProfilePage shows user data when loaded', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserLoaded(
      username: 'testuser',
      email: 'test@example.com',
      userId: '123',
      avatarBase64: 'dummyBase64',
      isAdmin: false,
      subscription: false,
    ));

    await tester.pumpWidget(wrapWithMaterialApp(ProfilePage()));
    await tester.pump();

    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('Update User'), findsOneWidget);
  });

  testWidgets('ProfilePage shows error message when error occurs', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserError('An error occurred'));

    await tester.pumpWidget(wrapWithMaterialApp(ProfilePage()));
    await tester.pump();

    expect(find.text('Error: An error occurred'), findsOneWidget);
  });

  testWidgets('ProfilePage calls UserBloc on refresh button press', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserLoaded(
      username: 'testuser',
      email: 'test@example.com',
      userId: '123',
      avatarBase64: 'dummyBase64',
      isAdmin: false,
      subscription: false,
    ));
    when(() => mockUserBloc.add(FetchUserEvent())).thenReturn(null);

    await tester.pumpWidget(wrapWithMaterialApp(ProfilePage()));
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    verify(() => mockUserBloc.add(FetchUserEvent())).called(2);
  });

  testWidgets('ProfilePage calls UserBloc on update button press', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserLoaded(
      username: 'testuser',
      email: 'test@example.com',
      userId: '123',
      avatarBase64: 'dummyBase64',
      isAdmin: false,
      subscription: false,
    ));
    when(() => mockUserBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(wrapWithMaterialApp(ProfilePage()));
    await tester.enterText(find.byType(TextField).at(0), 'newuser');
    await tester.enterText(find.byType(TextField).at(1), 'new@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'newpassword');
    await tester.tap(find.text('Update User'));
    await tester.pump();

    verify(() => mockUserBloc.add(UpdateUserEvent(UpdateUserParams(
      username: 'newuser',
      email: 'new@example.com',
      password: 'newpassword',
      avatar: 'dummyBase64',
    )))).called(1);
  });
}