import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/primary_button.dart';

class VpnInitialWidget extends StatelessWidget {
  const VpnInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Заголовок
          Text(
            'VPN',
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
          SizedBox(height: 2.h),
          // Круговой контейнер с иконкой
          Container(
            width: 25.h,
            height: 25.h,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(Icons.public, size: 12.h, color: colorScheme.outline),
            ),
          ),
          SizedBox(height: 4.h),
          // Кнопка "Connect"
          PrimaryButton(
            text: 'Connect',
            onPressed: () => context.read<VpnConnectionCubit>().connectVpn(),
          ),
        ],
      ),
    );
  }
}
