import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_state.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/vpn_connected_widget.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/vpn_connecting_widget.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/vpn_disconnected_widget.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/vpn_error_widget.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/vpn_initial_widget.dart';

class VpnConnectionPage extends StatelessWidget {
  const VpnConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Убираем AppBar, так как на макете его нет (или делаем прозрачным).
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<VpnConnectionCubit, VpnConnectionState>(
          builder: (context, state) {
            if (state is VpnInitial) {
              return const VpnInitialWidget();
            } else if (state is VpnConnecting) {
              return const VpnConnectingWidget();
            } else if (state is VpnConnected) {
              return VpnConnectedWidget(state: state);
            } else if (state is VpnError) {
              return VpnErrorWidget(state: state);
            } else if (state is VpnDisconnected) {
              return const VpnDisconnectedWidget();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
