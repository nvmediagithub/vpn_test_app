import 'package:hive/hive.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

part 'vpn_connection_model.g.dart';

@HiveType(typeId: 0)
class VpnConnectionModel {
  @HiveField(0)
  final bool isConnected;

  @HiveField(1)
  final DateTime? connectedAt;

  @HiveField(2)
  final int durationSeconds; // Храним длительность в секундах

  VpnConnectionModel({
    required this.isConnected,
    this.connectedAt,
    required this.durationSeconds,
  });

  factory VpnConnectionModel.fromEntity(VpnConnectionEntity entity) {
    return VpnConnectionModel(
      isConnected: entity.isConnected,
      connectedAt: entity.connectedAt,
      durationSeconds: entity.duration.inSeconds,
    );
  }
}
