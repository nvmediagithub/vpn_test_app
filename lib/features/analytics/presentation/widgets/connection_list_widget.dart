import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';
import 'connection_item_widget.dart';

class ConnectionListWidget extends StatelessWidget {
  final List<VpnConnectionEntity> connections;

  const ConnectionListWidget({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.dividerColor;
    final cardColor = theme.cardColor;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: ListView.separated(
          key: ValueKey(connections.length),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: connections.length,
          separatorBuilder: (_, __) => Divider(color: dividerColor),
          itemBuilder: (context, index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: ConnectionItemWidget(connection: connections[index]),
            );
          },
        ),
      ),
    );
  }
}
