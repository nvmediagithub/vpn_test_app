import 'package:dio/dio.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';

class VpnConnectionRepositoryImpl implements VpnConnectionRepository {
  final Dio dio;
  VpnConnectionRepositoryImpl({required this.dio});

  VpnConnectionEntity? _currentConnection;

  @override
  Future<void> connect() async {
    try {
      // Эмуляция запроса на сервер для подключения к VPN.
      // Здесь можно заменить URL на реальный API.
      // final response = await dio.get('https://127.0.0.1');
      // Если запрос успешен, эмулируем задержку подключения
      await Future.delayed(const Duration(seconds: 2));
      _currentConnection = VpnConnectionEntity(
        isConnected: true,
        connectedAt: DateTime.now(),
        duration: Duration.zero,
      );
    } catch (e) {
      throw Exception('Ошибка подключения: ${e.toString()}');
    }
  }

  @override
  Future<void> disconnect() async {
    _currentConnection = null;
  }

  @override
  Future<VpnConnectionEntity> getCurrentConnection() async {
    if (_currentConnection == null) {
      throw Exception('VPN не подключён');
    }
    final updatedConnection = VpnConnectionEntity(
      isConnected: true,
      connectedAt: _currentConnection!.connectedAt,
      duration: DateTime.now().difference(_currentConnection!.connectedAt!),
    );
    _currentConnection = updatedConnection;
    return updatedConnection;
  }
}
