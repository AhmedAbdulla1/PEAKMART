import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/features/auth/data/repository_imp.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';
import 'package:peakmart/features/auth/presentation/state_mang/login_cubit/cubit.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view_model.dart';
import 'package:peakmart/features/home/data/home_repo_imp.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';


final instance = GetIt.instance;

Future<void> initAppModule() async {
  final shardPref = await SharedPreferences.getInstance();
  // instance for shared pref
  instance.registerLazySingleton(() => shardPref);
  // instant for AppPreferences
  instance.registerLazySingleton(
    () => AppPreferences(
      instance<SharedPreferences>(),
    ),
  );
  instance.registerLazySingleton<NetWorkInfo>(
        () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  // instant for dioFactory
  // instance.registerLazySingleton<DioFactory>(
  //   () => DioFactory(
  //     instance<AppPreferences>(),
  //   ),
  // );
  //
  // // instant for AppServicesClient
  // Dio dio = await instance<DioFactory>().getDio();
  // instance.registerLazySingleton<AppServicesClient>(
  //   () => AppServicesClient(
  //     dio,
  //   ),
  // );
  // instance.registerLazySingleton<NotificationRepository>(
  //     () => NotificationRepositoryImpl());
  // // instant for remoteDataSource
  // instance.registerLazySingleton<RemoteDataSource>(
  //   () => RemoteDataSourceImpl(
  //     instance<AppServicesClient>(),
  //   ),
  // );
  // // instance for local data source
  // instance.registerLazySingleton<LocalDataSource>(
  //   () => LocalDataSourceImpl(),
  // );
  // //instant for repository
  // instance.registerLazySingleton<NotificationDataSource>(
  //   () => NotificationDataSourceImpl(instance<AppServicesClient>()),
  // );
  // instance.registerLazySingleton<OrderDataSource>(
  //     () => OrderDataSourceImpl(instance<AppServicesClient>()));
  //
  // instance.registerLazySingleton<Repository>(
  //   () => RepositoryImpl(
  //     instance<LocalDataSource>(),
  //     instance<RemoteDataSource>(),
  //     instance<NetWorkInfo>(),
  //   ),
  // );
  // //instance for notification usecase
  // instance.registerLazySingleton<NotificationsUseCase>(
  //   () => NotificationsUseCase(
  //     instance<NotificationRepository>(),
  //   ),
  // );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginViewModel>()) {
    instance.registerCachedFactory<LoginCubit>(()=> LoginCubit());
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel());
  }
  if (!GetIt.I.isRegistered<AuthRepo>()) {
    instance.registerCachedFactory<AuthRepo>(()=> AuthRepositoryImp());
  }
}
initHomeModule() {
  if(!GetIt.I.isRegistered<HomeRepository>()){
    instance.registerCachedFactory<HomeRepository>(()=>HomeRepositoryImp());
  }
}
//
// initChatModule() {
//   if (!GetIt.I.isRegistered<ChatDataSource>()) {
//     instance.registerFactory<ChatDataSource>(
//         () => ChatDataSourceImpl(instance<AppServicesClient>()));
//   }
//   if (!GetIt.I.isRegistered<ChatRepository>()) {
//     instance.registerFactory<ChatRepository>(() => ChatRepositoryImp());
//   }
//
//   if (!GetIt.I.isRegistered<ChatUseCase>()) {
//     instance.registerFactory<ChatUseCase>(() => ChatUseCase());
//   }
//   if (!GetIt.I.isRegistered<OrderUseCase>()) {
//     instance.registerFactory<OrderUseCase>(() => OrderUseCase());
//   }
// }
//
// initOTPModule() {
//   if (!GetIt.I.isRegistered<OTPViewModel>()) {
//     // instance.registerFactory<LoginUseCase>(
//     // () => LoginUseCase(instance<Repository>()));
//     instance.registerFactory<OTPViewModel>(() => OTPViewModel());
//   }
// }
//
// initRegisterModule() {
//   if (!GetIt.I.isRegistered<RegisterUseCase>()) {
//     instance.registerFactory<RegisterUseCase>(
//         () => RegisterUseCase(instance<Repository>()));
//     instance.registerFactory<RegisterViewModel>(
//         () => RegisterViewModel(instance<RegisterUseCase>()));
//     if (!GetIt.I.isRegistered<ImagePicker>()) {
//       instance.registerFactory<ImagePicker>(() => ImagePicker());
//     }
//   }
// }
