import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

class ConnectionLineChartWidget extends StatelessWidget {
  final List<VpnConnectionEntity> connections;

  const ConnectionLineChartWidget({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (connections.isEmpty) {
      return Center(
        child: Text(
          'No Data',
          style: textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
        ),
      );
    }

    final maxSeconds = connections
        .map((e) => e.duration.inSeconds)
        .reduce((a, b) => a > b ? a : b);

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxSeconds.toDouble() + 5,
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine:
              (value) => FlLine(
                color: theme.dividerColor.withOpacity(0.2),
                strokeWidth: 1,
              ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < connections.length &&
                    connections[index].connectedAt != null) {
                  return Transform.rotate(
                    angle: -pi / 2,
                    child: Text(
                      DateFormat(
                        'MM/dd',
                      ).format(connections[index].connectedAt!),
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget:
                  (value, meta) => Text(
                    '${value.toInt()}s',
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.x.toInt();
                final date = connections[index].connectedAt!;
                final seconds = connections[index].duration.inSeconds;
                return LineTooltipItem(
                  '${DateFormat('MMM d').format(date)}\n$seconds sec',
                  textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            curveSmoothness: 0.25,
            isStrokeCapRound: true,
            gradient: LinearGradient(
              colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                final isMax =
                    connections[index.toInt()].duration.inSeconds == maxSeconds;
                return FlDotCirclePainter(
                  radius: isMax ? 5 : 4,
                  color: isMax ? Colors.redAccent : theme.primaryColor,
                  strokeWidth: 1.5,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withOpacity(0.25),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            spots: List.generate(connections.length, (index) {
              final seconds = connections[index].duration.inSeconds.toDouble();
              return FlSpot(index.toDouble(), seconds);
            }),
          ),
        ],
      ),
    );
  }
}
