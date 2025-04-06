import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive/hive.dart';
import 'package:vpn_app/features/vpn_connection/data/models/vpn_connection_model.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';

class VpnConnectionRepositoryImpl implements VpnConnectionRepository {
  final Dio dio;
  final FirebaseAnalytics analytics;
  final Box<VpnConnectionModel> vpnLogsBox;

  VpnConnectionRepositoryImpl({
    required this.dio,
    required this.analytics,
    required this.vpnLogsBox,
  });

  VpnConnectionEntity? _currentConnection;

  @override
  Future<VpnConnectionEntity> connect() async {
    try {
      // Эмуляция запроса на сервер для подключения к VPN.
      await Future.delayed(const Duration(seconds: 2));
      final now = DateTime.now();
      _currentConnection = VpnConnectionEntity(
        isConnected: true,
        connectedAt: now,
        duration: Duration.zero,
      );
      // Логирование события подключения в Firebase Analytics.
      await analytics.logEvent(
        name: 'vpn_connected',
        parameters: {'connected_at': now.toIso8601String()},
      );
      // Сохраняем первоначальный лог подключения (duration = 0)
      final model = VpnConnectionModel.fromEntity(_currentConnection!);
      await vpnLogsBox.add(model);
      return _currentConnection!;
    } catch (e) {
      throw Exception('Ошибка подключения: ${e.toString()}');
    }
  }

  @override
  Future<void> disconnect() async {
    try {
      if (_currentConnection == null) {
        throw Exception('VPN не подключён');
      }
      final now = DateTime.now();
      // Вычисляем фактическую длительность подключения.
      final updatedConnection = VpnConnectionEntity(
        isConnected: false,
        connectedAt: _currentConnection!.connectedAt,
        duration: now.difference(_currentConnection!.connectedAt!),
      );
      // Логирование события отключения в Firebase Analytics.
      await analytics.logEvent(
        name: 'vpn_disconnected',
        parameters: {'disconnected_at': now.toIso8601String()},
      );
      // Сохраняем лог завершённой сессии с обновлённой длительностью.
      final model = VpnConnectionModel.fromEntity(updatedConnection);
      await vpnLogsBox.add(model);
      _currentConnection = null;
    } catch (e) {
      throw Exception('Ошибка отключения: ${e.toString()}');
    }
  }
}
