import 'package:get_it/get_it.dart';
import 'package:open_nest/core/network/hive_service.dart';
import 'package:open_nest/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:open_nest/features/auth/domain/use_case/login_usecase.dart';
import 'package:open_nest/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:open_nest/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
import 'package:open_nest/features/onboarding/presentation/view_model/onboarding_cubit.dart';
// import 'package:open_nest/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:open_nest/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive service
  await _initHiveService();

  // Initialize Register and Login Dependencies
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initHomeDependencies();
  await _initonboardScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // Initialize local data source
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // Initialize local repository
  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // Register Register UseCase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthLocalRepository>()),
  );

  // Register Register Bloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(registerUseCase: getIt()),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}

_initLoginDependencies() async {
  // Initialize Login UseCase
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthLocalRepository>()),
  );

  // Register Login Bloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      loginUseCase: getIt<LoginUseCase>(),
      dashboardCubit: getIt<DashboardCubit>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}


_initonboardScreenDependencies() {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}




