import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/core/network/api_service.dart';
import 'package:open_nest/core/network/hive_service.dart';
import 'package:open_nest/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:open_nest/features/auth/domain/use_case/get_Current_user.dart';
import 'package:open_nest/features/auth/domain/use_case/login_usecase.dart';
import 'package:open_nest/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
import 'package:open_nest/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:open_nest/features/comments/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:open_nest/features/comments/data/data_source/remote_datasource/comment_remote_datasource.dart';
import 'package:open_nest/features/comments/data/repository/comment_local_repository.dart';
import 'package:open_nest/features/comments/data/repository/comment_remote_repository.dart';
import 'package:open_nest/features/comments/domain/use_case/create_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/delete_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/get_all_comment_usecase.dart';
import 'package:open_nest/features/comments/domain/use_case/get_comments_by_id.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
// import 'package:open_nest/features/home/presentation/view_model/search/search_bloc.dart';
import 'package:open_nest/features/like/data/data_source/local_datasource/like_local_data_source.dart';
import 'package:open_nest/features/like/data/data_source/remote_datasource/like_remote_datasource.dart';
import 'package:open_nest/features/like/data/repository/like_local_repository.dart';
import 'package:open_nest/features/like/data/repository/like_remote_repository.dart';
import 'package:open_nest/features/like/domain/use_case/create_like_usecase.dart';
import 'package:open_nest/features/like/domain/use_case/delete_like_usecase.dart';
import 'package:open_nest/features/like/domain/use_case/get_all_course_usecase.dart';
import 'package:open_nest/features/like/domain/use_case/get_likes_by_id.dart';
import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
import 'package:open_nest/features/listing/data/data_source/local_datasource/listing_local_data_source.dart';
import 'package:open_nest/features/listing/data/data_source/remote_datasource/listing_remote_datasource.dart';
import 'package:open_nest/features/listing/data/repository/listing_local_repository.dart';
import 'package:open_nest/features/listing/data/repository/listing_remote_repository.dart';
import 'package:open_nest/features/listing/domain/use_case/create_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/delete_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/get_all_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/get_listing_by_id_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/update_Usecase.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';
import 'package:open_nest/features/onboarding/presentation/view_model/onboarding_cubit.dart';
// import 'package:open_nest/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:open_nest/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
import '../../features/auth/domain/use_case/upload_image_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  // Initialize Register and Login Dependencies
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initHomeDependencies();
  await _initonboardScreenDependencies();
  await _initListingDependencies();
  await _initLikeDependencies();
  await _initCommentDependencies();

   
  
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initListingDependencies() async {
  // =========================== Data Source ===========================
  getIt.registerFactory<ListingLocalDataSource>(
      () => ListingLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<ListingRemoteDataSource>(
    () => ListingRemoteDataSource(
       getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton<ListingLocalRepository>(() => ListingLocalRepository(
      listingLocalDataSource: getIt<ListingLocalDataSource>()));

  getIt.registerLazySingleton(
    () => ListingRemoteRepository(
       getIt<ListingRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateListingUsecase>(
    () => CreateListingUsecase( listingRepository: getIt<ListingRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(), 
     ),
  );

  getIt.registerLazySingleton<GetAllListingUsecase>(
    () => GetAllListingUsecase(listingRepository: getIt<ListingRemoteRepository>()),
  );

   getIt.registerLazySingleton<GetUserListingUsecase>(
    () => GetUserListingUsecase( listingRepository: getIt<ListingRemoteRepository>(),tokenSharedPrefs: getIt<TokenSharedPrefs>(),),
  );

  getIt.registerLazySingleton<DeleteListingUsecase>(
    () => DeleteListingUsecase(
      listingRepository: getIt<ListingRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<UpdateListingUsecase>(
    () => UpdateListingUsecase(
      listingRepository: getIt<ListingRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<ListingBloc>(
    () => ListingBloc(getAllListingUsecase:  getIt<GetAllListingUsecase>(), 
    createListingUsecase: getIt<CreateListingUsecase>(),
     deleteListingUsecase: getIt<DeleteListingUsecase>(), 
     updateListingUsecase: getIt<UpdateListingUsecase>(), getUserListingUsecase: getIt<GetUserListingUsecase>(),
      
    ),
  );
}



_initLikeDependencies() async {
  // =========================== Data Source ===========================
  getIt.registerFactory<LikeLocalDataSource>(
      () => LikeLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<LikeRemoteDataSource>(
    () => LikeRemoteDataSource(
       getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton<LikeLocalRepository>(() => LikeLocalRepository(
      likeLocalDataSource: getIt<LikeLocalDataSource>()));

  getIt.registerLazySingleton(
    () => LikeRemoteRepository(
       getIt<LikeRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateLikeUsecase>(
    () => CreateLikeUsecase(likeRepository: getIt<LikeRemoteRepository>(),tokenSharedPrefs: getIt<TokenSharedPrefs>(),),
  );

  getIt.registerLazySingleton<GetAllLikeUsecase>(
    () => GetAllLikeUsecase(likeRepository: getIt<LikeRemoteRepository>()),
  );
getIt.registerLazySingleton<GetLikesByListingUsecase>(
    () => GetLikesByListingUsecase(likeRepository: getIt<LikeRemoteRepository>(), tokenSharedPrefs:getIt<TokenSharedPrefs>(),),
  );

  getIt.registerLazySingleton<DeleteLikeUsecase>(
    () => DeleteLikeUsecase(
      likeRepository: getIt<LikeRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<LikeBloc>(
    () => LikeBloc(getAllLikeUsecase:  getIt<GetAllLikeUsecase>(), 
    createLikeUsecase: getIt<CreateLikeUsecase>(),
     deleteLikeUsecase: getIt<DeleteLikeUsecase>(),
     getLikesByListingUsecase: getIt<GetLikesByListingUsecase>(),
      
    ),
  );
}



_initCommentDependencies() async {
  // =========================== Data Source ===========================
  getIt.registerFactory<CommentLocalDataSource>(
      () => CommentLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<CommentRemoteDataSource>(
    () => CommentRemoteDataSource(
       getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton<CommentLocalRepository>(() => CommentLocalRepository(
      commentLocalDataSource: getIt<CommentLocalDataSource>()));

  getIt.registerLazySingleton(
    () => CommentRemoteRepository(
       getIt<CommentRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateCommentUsecase>(
    () => CreateCommentUsecase(commentRepository: getIt<CommentRemoteRepository>(),
    tokenSharedPrefs: getIt<TokenSharedPrefs>(),)
  );

  getIt.registerLazySingleton<GetAllCommentUsecase>(
    () => GetAllCommentUsecase(commentRepository: getIt<CommentRemoteRepository>()),
  );
   getIt.registerLazySingleton<GetCommentsByListingUsecase>(
    () => GetCommentsByListingUsecase(commentRepository: getIt<CommentRemoteRepository>(), tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<DeleteCommentUsecase>(
    () => DeleteCommentUsecase(
      commentRepository: getIt<CommentRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<CommentBloc>(
    () => CommentBloc(getAllCommentUsecase:  getIt<GetAllCommentUsecase>(), 
    createCommentUsecase: getIt<CreateCommentUsecase>(),
     deleteCommentUsecase: getIt<DeleteCommentUsecase>(), getCommentsByListingUsecase: getIt<GetCommentsByListingUsecase>(), 
    // getCommentsByListingUsecase: getIt<GetCommentsByListingUsecase>(),
      
    ),
  );
}





_initRegisterDependencies() {
  // Initialize local data source
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

    // Initialize remote data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // Initialize local repository
  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

    // Initialize remote repository
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // Register Register UseCase
  getIt.registerLazySingleton<RegisterUseCase>(
  //     () => RegisterUseCase(getIt<AuthLocalRepository>()),
  // );
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // Register Register Bloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(registerUseCase: getIt(),
          uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
  
}

_initLoginDependencies() async {

  getIt.registerLazySingleton<TokenSharedPrefs>(
     () => TokenSharedPrefs(getIt<SharedPreferences>())
  );

  // Initialize Login UseCase
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRemoteRepository>(),
     getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerLazySingleton<FetchCurrentUserUseCase>(
    () => FetchCurrentUserUseCase( tokenSharedPrefs:  getIt<TokenSharedPrefs>(), repository: getIt<AuthRemoteRepository>(),
     
    ),
  );
 getIt.registerLazySingleton<UpdateUserUsecase>(
    () => UpdateUserUsecase( tokenSharedPrefs:  getIt<TokenSharedPrefs>(), authRepository: getIt<AuthRemoteRepository>(),
     
    ),
  );
  // Register Login Bloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      loginUseCase: getIt<LoginUseCase>(),
      dashboardCubit: getIt<DashboardCubit>(),
    ),
  );

   getIt.registerFactory<UserBloc>(
    () => UserBloc(fetchCurrentUserUseCase: getIt<FetchCurrentUserUseCase>(), updateUserUsecase: getIt<UpdateUserUsecase>(),
    
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

_initApiService(){
  //Remote Data Source
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio,
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}



