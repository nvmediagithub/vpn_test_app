import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_state.dart';

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
              return _buildInitial(context);
            } else if (state is VpnConnecting) {
              return _buildConnecting();
            } else if (state is VpnConnected) {
              return _buildConnected(context, state);
            } else if (state is VpnError) {
              return _buildError(context, state);
            } else if (state is VpnDisconnected) {
              return _buildDisconnected(context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // Экран начального состояния
  Widget _buildInitial(BuildContext context) {
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
          // Круговой контейнер с иконкой (отключённое состояние)
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
          // Кнопка "Подключиться"
          ElevatedButton(
            onPressed: () {
              context.read<VpnConnectionCubit>().connectVpn();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Подключиться',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Экран подключения (отображаем индикатор)
  Widget _buildConnecting() {
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
          // Статус "Connecting..."
          Text(
            'Connecting...',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 2.h),
          // Круговой контейнер с индикатором процесса
          Container(
            width: 25.h,
            height: 25.h,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(
                width: 15.h,
                height: 15.h,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  strokeWidth: 4,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text('Пожалуйста, подождите', style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }

  // Экран при успешном подключении
  Widget _buildConnected(BuildContext context, VpnConnected state) {
    final connectedTime = _formatDuration(state.connection.duration);

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
          // Статус "Connected"
          Text(
            'Connected',
            style: TextStyle(fontSize: 12.sp, color: Colors.green),
          ),
          SizedBox(height: 1.h),
          // Таймер
          Text(
            connectedTime,
            style: TextStyle(fontSize: 12.sp, color: Colors.black87),
          ),
          SizedBox(height: 4.h),
          // Круг с иконкой глобуса
          Container(
            width: 25.h,
            height: 25.h,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Center(
              // Можно заменить на свою иконку или изображение глобуса
              child: Icon(Icons.public, size: 12.h, color: Colors.blueAccent),
            ),
          ),
          SizedBox(height: 4.h),
          // Кнопка Disconnect
          ElevatedButton(
            onPressed: () {
              context.read<VpnConnectionCubit>().disconnectVpn();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Disconnect',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Экран ошибки
  Widget _buildError(BuildContext context, VpnError state) {
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
          ElevatedButton(
            onPressed: () {
              context.read<VpnConnectionCubit>().connectVpn();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Retry',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Экран при отключенном VPN
  Widget _buildDisconnected(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Заголовок
          Text(
            'VPN',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          // Статус
          Text(
            'Disconnected',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          // Круг с иконкой глобуса (сделаем блеклый)
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
          // Кнопка Connect
          ElevatedButton(
            onPressed: () {
              context.read<VpnConnectionCubit>().connectVpn();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Connect',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Вспомогательный метод форматирования времени (MM:SS)
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
