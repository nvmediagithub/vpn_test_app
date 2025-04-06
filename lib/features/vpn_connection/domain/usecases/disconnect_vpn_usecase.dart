import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';

class DisconnectVpnUseCase {
  final VpnConnectionRepository repository;

  DisconnectVpnUseCase(this.repository);

  Future<void> call() async {
    return await repository.disconnect();
  }
}
