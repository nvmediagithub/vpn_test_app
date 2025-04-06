class VpnConnectionEntity {
  final bool isConnected;
  final DateTime? connectedAt;
  final Duration duration;

  VpnConnectionEntity({
    required this.isConnected,
    this.connectedAt,
    required this.duration,
  });
}
