import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app/features/analytics/domain/usecases/get_last_connections_usecase.dart';
import 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final GetLastConnectionsUseCase useCase;

  AnalyticsCubit({required this.useCase}) : super(AnalyticsInitial());

  Future<void> loadAnalytics() async {
    emit(AnalyticsLoading());
    try {
      final connections = await useCase();
      emit(AnalyticsLoaded(connections: connections));
    } catch (error) {
      emit(AnalyticsError(message: error.toString()));
    }
  }
}
