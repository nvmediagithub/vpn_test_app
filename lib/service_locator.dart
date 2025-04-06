// lib/service_locator.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vpn_app/features/vpn_connection/data/repositories/vpn_connection_repository_impl.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';

final sl = GetIt.instance;

void setup() {
  // Регистрируем Dio как синглтон
  sl.registerLazySingleton<Dio>(() => Dio());

  // Регистрируем реализацию VpnRepository, используя Dio
  sl.registerLazySingleton<VpnConnectionRepository>(
    () => VpnConnectionRepositoryImpl(dio: sl<Dio>()),
  );
}
