import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:vpn_app/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:vpn_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:vpn_app/features/vpn_connection/data/models/vpn_connection_model.dart';

import 'package:vpn_app/features/vpn_connection/data/repositories/vpn_connection_repository_impl.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';

final sl = GetIt.instance;

void setup() {
  // Регистрируем Dio как синглтон
  sl.registerLazySingleton<Dio>(() => Dio());
  // Регистрируем Firebase Analytics как синглтон
  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  // Предполагается, что Hive уже инициализирован и открыт box 'vpnLogsBox'
  sl.registerLazySingleton<Box<VpnConnectionModel>>(
    () => Hive.box<VpnConnectionModel>('vpnLogsBox'),
  );

  // Регистрируем реализацию VpnRepository, используя Dio
  sl.registerLazySingleton<VpnConnectionRepository>(
    () => VpnConnectionRepositoryImpl(
      dio: sl<Dio>(),
      analytics: sl<FirebaseAnalytics>(),
      vpnLogsBox: sl<Box<VpnConnectionModel>>(),
    ),
  );
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(
      vpnLogsBox: Hive.box<VpnConnectionModel>('vpnLogsBox'),
    ),
  );
}
