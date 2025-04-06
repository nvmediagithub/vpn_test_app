import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vpn_app/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:vpn_app/features/analytics/presentation/cubit/analytics_state.dart';
import 'package:vpn_app/features/analytics/presentation/widgets/connection_line_chart_widget.dart';
import 'package:vpn_app/features/analytics/presentation/widgets/connection_list_widget.dart';
import 'package:vpn_app/features/vpn_connection/domain/entities/vpn_connection_entity.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    context.read<AnalyticsCubit>().loadAnalytics();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Analytics',
          style: textTheme.titleLarge?.copyWith(fontSize: 24.sp),
        ),
      ),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          if (state is AnalyticsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnalyticsError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            );
          } else if (state is AnalyticsLoaded) {
            final connections = state.connections;
            connections.sort((a, b) {
              if (a.connectedAt == null || b.connectedAt == null) return 0;
              return b.connectedAt!.compareTo(a.connectedAt!);
            });

            final lastFive = connections.take(5).toList();
            final ascendingList = List<VpnConnectionEntity>.from(lastFive)
              ..sort((a, b) {
                if (a.connectedAt == null || b.connectedAt == null) return 0;
                return a.connectedAt!.compareTo(b.connectedAt!);
              });

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Connections',
                      style: textTheme.titleLarge?.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      height: 30.h,
                      child: ConnectionLineChartWidget(
                        connections: ascendingList,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Recent Connections',
                      style: textTheme.titleLarge?.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 2.h),
                    ConnectionListWidget(connections: lastFive),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
