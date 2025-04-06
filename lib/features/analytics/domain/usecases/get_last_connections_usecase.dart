import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';
import '../repositories/analytics_repository.dart';

class GetLastConnectionsUseCase {
  final AnalyticsRepository repository;

  GetLastConnectionsUseCase(this.repository);

  Future<List<VpnConnectionEntity>> call() async {
    return await repository.getLastConnections();
  }
}
