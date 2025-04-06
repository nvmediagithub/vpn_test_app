import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app/features/vpn_connection/domain/usecases/connect_vpn_usecase.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_state.dart';

class VpnConnectionCubit extends Cubit<VpnConnectionState> {
  final ConnectVpnUseCase connectUseCase;

  VpnConnectionCubit({required this.connectUseCase}) : super(VpnInitial());

  Future<void> connectVpn() async {
    emit(VpnConnecting());
    try {
      final connection = await connectUseCase();
      emit(VpnConnected(connection: connection));
    } catch (error) {
      emit(VpnError(message: error.toString()));
    }
  }

  Future<void> disconnectVpn() async {
    // Здесь можно вызвать метод disconnect из репозитория, если потребуется
    emit(VpnDisconnected());
  }
}
