import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';
import 'package:vpn_app/features/vpn_connection/domain/usecases/connect_vpn_usecase.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/pages/vpn_connection_page.dart';
import 'package:vpn_app/service_locator.dart' as di;

void main() {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'VPN App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocProvider(
            create:
                (context) => VpnConnectionCubit(
                  connectUseCase: ConnectVpnUseCase(
                    di.sl<VpnConnectionRepository>(),
                  ),
                ),
            child: const VpnConnectionPage(),
          ),
        );
      },
    );
  }
}
