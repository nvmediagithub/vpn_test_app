import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VpnConnectingWidget extends StatefulWidget {
  const VpnConnectingWidget({super.key});

  @override
  State<VpnConnectingWidget> createState() => _VpnConnectingWidgetState();
}

class _VpnConnectingWidgetState extends State<VpnConnectingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                'Connecting...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      strokeWidth: 4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Please wait...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
