import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

abstract class VpnConnectionRepository {
  Future<void> connect();
  Future<void> disconnect();
  Future<VpnConnectionEntity> getCurrentConnection();
}
