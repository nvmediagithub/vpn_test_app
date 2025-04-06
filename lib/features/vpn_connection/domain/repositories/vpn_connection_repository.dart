import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

abstract class VpnConnectionRepository {
  Future<VpnConnectionEntity> connect();
  Future<void> disconnect();
}
