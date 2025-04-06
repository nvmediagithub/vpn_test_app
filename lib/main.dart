import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:vpn_app/features/analytics/domain/usecases/get_last_connections_usecase.dart';
import 'package:vpn_app/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:vpn_app/features/home/presentation/pages/home_screen.dart';
import 'package:vpn_app/features/vpn_connection/data/models/vpn_connection_model.dart';
import 'package:vpn_app/features/vpn_connection/domain/repositories/vpn_connection_repository.dart';
import 'package:vpn_app/features/vpn_connection/domain/usecases/connect_vpn_usecase.dart';
import 'package:vpn_app/features/vpn_connection/domain/usecases/disconnect_vpn_usecase.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/pages/vpn_connection_page.dart';
import 'package:vpn_app/service_locator.dart' as di;
import 'package:vpn_app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(VpnConnectionModelAdapter());
  await Hive.openBox<VpnConnectionModel>('vpnLogsBox');

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
          home: MultiBlocProvider(
            providers: [
              // Предоставляем и CharacterCubit, и FavoriteCubit
              BlocProvider<VpnConnectionCubit>(
                create:
                    (context) => VpnConnectionCubit(
                      connectUseCase: ConnectVpnUseCase(
                        di.sl<VpnConnectionRepository>(),
                      ),
                      disconnectUseCase: DisconnectVpnUseCase(
                        di.sl<VpnConnectionRepository>(),
                      ),
                    ),
                child: const VpnConnectionPage(),
              ),
              BlocProvider<AnalyticsCubit>(
                create:
                    (context) => AnalyticsCubit(
                      useCase: GetLastConnectionsUseCase(
                        di.sl<AnalyticsRepository>(),
                      ),
                    ),
                child: const VpnConnectionPage(),
              ),
            ],
            child: MaterialApp(
              title: 'VPN App',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light, // или ThemeMode.system
              home: const HomeScreen(),
            ),
          ),
        );
      },
    );
  }
}
