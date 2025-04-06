import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/primary_button.dart';

class VpnDisconnectedWidget extends StatelessWidget {
  const VpnDisconnectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'VPN',
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 20.sp),
          ),
          SizedBox(height: 2.h),
          Text('Disconnected', style: theme.textTheme.bodyMedium),
          SizedBox(height: 4.h),
          Container(
            width: 25.h,
            height: 25.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.public, size: 12.h, color: Colors.grey),
            ),
          ),
          SizedBox(height: 4.h),
          PrimaryButton(
            text: 'Connect',
            onPressed: () {
              context.read<VpnConnectionCubit>().connectVpn();
            },
          ),
        ],
      ),
    );
  }
}
