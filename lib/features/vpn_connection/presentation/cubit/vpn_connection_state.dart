import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

abstract class VpnConnectionState {}

class VpnInitial extends VpnConnectionState {}

class VpnConnecting extends VpnConnectionState {}

class VpnConnected extends VpnConnectionState {
  final VpnConnectionEntity connection;
  VpnConnected({required this.connection});
}

class VpnDisconnected extends VpnConnectionState {}

class VpnError extends VpnConnectionState {
  final String message;
  VpnError({required this.message});
}
