import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vpn_app/features/vpn_connection/data/models/vpn_connection_model.dart';
import 'package:vpn_app/features/vpn_connection/data/repositories/vpn_connection_repository_impl.dart';

import 'vpn_connection_repository_impl_test.mocks.dart';

@GenerateMocks([Dio, FirebaseAnalytics, Box<VpnConnectionModel>])
void main() {
  late MockDio mockDio;
  late MockFirebaseAnalytics mockAnalytics;
  late MockBox<VpnConnectionModel> mockBox;
  late VpnConnectionRepositoryImpl repository;

  setUp(() {
    mockDio = MockDio();
    mockAnalytics = MockFirebaseAnalytics();
    mockBox = MockBox<VpnConnectionModel>();
    repository = VpnConnectionRepositoryImpl(
      dio: mockDio,
      analytics: mockAnalytics,
      vpnLogsBox: mockBox,
    );
  });

  test(
    'connect() должен установить подключение и сохранить лог в Hive',
    () async {
      // arrange
      when(
        mockAnalytics.logEvent(
          name: anyNamed('name'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) async {});
      when(mockBox.add(any)).thenAnswer((_) async => 0);

      // act
      final connection = await repository.connect();

      // assert
      expect(connection.isConnected, true);
      expect(connection.duration, Duration.zero);
      verify(
        mockAnalytics.logEvent(
          name: 'vpn_connected',
          parameters: anyNamed('parameters'),
        ),
      ).called(1);
      verify(mockBox.add(any)).called(1);
    },
  );

  test(
    'disconnect() без активного подключения должен выбрасывать исключение',
    () async {
      // act & assert: если подключения нет, то вызов disconnect() должен бросить Exception
      expect(() => repository.disconnect(), throwsException);
    },
  );

  test(
    'disconnect() должен логировать событие и сбрасывать подключение при активной сессии',
    () async {
      // arrange: сначала устанавливаем подключение
      when(
        mockAnalytics.logEvent(
          name: anyNamed('name'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) async {});
      when(mockBox.add(any)).thenAnswer((_) async => 0);

      await repository.connect();

      // act: отключаем VPN
      await repository.disconnect();

      // assert: после отключения повторный вызов disconnect() должен бросать исключение,
      // а событие 'vpn_disconnected' должно быть залогировано
      expect(() => repository.disconnect(), throwsException);
      verify(
        mockAnalytics.logEvent(
          name: 'vpn_disconnected',
          parameters: anyNamed('parameters'),
        ),
      ).called(1);

      // Проверяем, что в Hive было сохранено не менее 2 записей:
      // одна при подключении и одна при отключении
      verify(mockBox.add(any)).called(greaterThanOrEqualTo(2));
    },
  );
}
