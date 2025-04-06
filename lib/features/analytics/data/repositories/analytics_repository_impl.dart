import 'package:hive/hive.dart';
import 'package:vpn_app/features/vpn_connection/data/models/vpn_connection_model.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';
import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final Box<VpnConnectionModel> vpnLogsBox;

  AnalyticsRepositoryImpl({required this.vpnLogsBox});

  @override
  Future<List<VpnConnectionEntity>> getLastConnections() async {
    // Читаем все записи из Hive
    final models = vpnLogsBox.values.toList();

    // Сортируем по времени подключения (от новых к старым)
    models.sort((a, b) {
      if (a.connectedAt == null || b.connectedAt == null) return 0;
      return b.connectedAt!.compareTo(a.connectedAt!);
    });

    // Берем последние 5 записей (если их меньше, берем все)
    final lastFiveModels = models.take(5).toList();

    // Преобразуем каждую модель в доменную сущность
    final entities =
        lastFiveModels.map((model) {
          return VpnConnectionEntity(
            isConnected: model.isConnected,
            connectedAt: model.connectedAt,
            duration: Duration(seconds: model.durationSeconds),
          );
        }).toList();

    return entities;
  }
}
