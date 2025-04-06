import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_state.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/primary_button.dart';

class VpnErrorWidget extends StatelessWidget {
  final VpnError state;

  const VpnErrorWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Заголовок "VPN"
          Text(
            'VPN',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          // Круг с иконкой ошибки
          Container(
            width: 25.h,
            height: 25.h,
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.error_outline,
                size: 12.h,
                color: Colors.redAccent,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          // Статус ошибки
          Text('Error', style: TextStyle(fontSize: 12.sp, color: Colors.red)),
          SizedBox(height: 1.h),
          // Сообщение об ошибке
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.red),
            ),
          ),
          SizedBox(height: 4.h),
          // Кнопка "Retry"
          PrimaryButton(
            text: 'Retry',
            onPressed: () => context.read<VpnConnectionCubit>().connectVpn(),
          ),
        ],
      ),
    );
  }
}
