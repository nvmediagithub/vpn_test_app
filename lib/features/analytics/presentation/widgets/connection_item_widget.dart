import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

class ConnectionItemWidget extends StatelessWidget {
  final VpnConnectionEntity connection;

  const ConnectionItemWidget({super.key, required this.connection});

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds;
    if (minutes < 1) return '${seconds}s';
    return '${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Дата и время
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMM d, yyyy').format(connection.connectedAt!),
              style: textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 0.5.h),
            Text(
              DateFormat('HH:mm').format(connection.connectedAt!),
              style: textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        // Длительность
        Text(
          _formatDuration(connection.duration),
          style: textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        ),
      ],
    );
  }
}
