import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';

class ConnectVpnUseCase {
  final VpnConnectionRepository repository;

  ConnectVpnUseCase(this.repository);

  Future<VpnConnectionEntity> call() async {
    return await repository.getCurrentConnection();
  }
}
