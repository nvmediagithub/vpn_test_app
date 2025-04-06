import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final List<VpnConnectionEntity> connections;
  AnalyticsLoaded({required this.connections});
}

class AnalyticsError extends AnalyticsState {
  final String message;
  AnalyticsError({required this.message});
}
