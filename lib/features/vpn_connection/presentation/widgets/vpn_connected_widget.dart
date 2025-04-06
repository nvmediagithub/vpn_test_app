import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_cubit.dart';
import 'package:vpn_app/features/vpn_connection/presentation/cubit/vpn_connection_state.dart';
import 'package:vpn_app/features/vpn_connection/presentation/widgets/primary_button.dart';

class VpnConnectedWidget extends StatefulWidget {
  final VpnConnected state;
  const VpnConnectedWidget({super.key, required this.state});

  @override
  State<VpnConnectedWidget> createState() => _VpnConnectedWidgetState();
}

class _VpnConnectedWidgetState extends State<VpnConnectedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VPN',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Text(
                'Connected',
                style: TextStyle(fontSize: 24.sp, color: Colors.green),
              ),
              SizedBox(height: 1.h),
              StreamBuilder<DateTime>(
                stream: Stream.periodic(
                  const Duration(seconds: 1),
                  (_) => DateTime.now(),
                ),
                builder: (context, snapshot) {
                  final now = snapshot.data ?? DateTime.now();
                  final duration = now.difference(
                    state.connection.connectedAt!,
                  );
                  return Text(
                    _formatDuration(duration),
                    style: TextStyle(fontSize: 18.sp, color: Colors.black87),
                  );
                },
              ),
              SizedBox(height: 4.h),
              Container(
                width: 25.h,
                height: 25.h,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.public,
                    size: 12.h,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              PrimaryButton(
                text: 'Disconnect',
                onPressed: () {
                  context.read<VpnConnectionCubit>().disconnectVpn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
