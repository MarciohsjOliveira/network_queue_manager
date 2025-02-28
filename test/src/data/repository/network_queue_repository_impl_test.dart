import 'package:mocktail/mocktail.dart';
import 'package:network_queue_manager/src/data/repository/network_queue_repository_impl.dart';
import 'package:network_queue_manager/src/domain/domain.dart';
import 'package:network_queue_manager/src/data/datasource/datasource.dart';
import 'package:network_queue_manager/src/domain/enums/enums.dart' show HttpMethod;
import 'package:test/test.dart';

class MockQueueLocalDataSource extends Mock implements QueueLocalDataSource {}

void main() {
  late NetworkQueueRepositoryImpl repository;
  late MockQueueLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockQueueLocalDataSource();
    repository = NetworkQueueRepositoryImpl(mockDataSource);
  });

  group('NetworkQueueRepositoryImpl', () {
    final testRequest = NetworkRequest(
      id: '1',
      url: 'https://example.com',
      method: HttpMethod.GET,
    );

    final duplicateRequest = NetworkRequest(
      id: '1',
      url: 'https://duplicate.com',
      method: HttpMethod.GET,
    );

    test('should add a request', () async {
      // arrange
      when(() => mockDataSource.saveRequest(testRequest))
          .thenAnswer((_) async {});
      // act
      await repository.addRequest(testRequest);
      // assert
      verify(() => mockDataSource.saveRequest(testRequest)).called(1);
    });

    test('should get pending requests when cache is empty', () async {
      // arrange
      final testRequests = [testRequest];
      when(() => mockDataSource.fetchPendingRequests())
          .thenAnswer((_) async => testRequests);
      // act
      final result = await repository.getPendingRequests();
      // assert
      expect(result, testRequests);
      verify(() => mockDataSource.fetchPendingRequests()).called(1);
    });

    test('should process queue by fetching and removing each unique request', () async {
      // arrange
      final testRequests = [testRequest];
      when(() => mockDataSource.fetchPendingRequests())
          .thenAnswer((_) async => testRequests);
      when(() => mockDataSource.removeRequest(testRequest.id))
          .thenAnswer((_) async {});
      // act
      await repository.processQueue();
      // assert
      verify(() => mockDataSource.fetchPendingRequests()).called(1);
      verify(() => mockDataSource.removeRequest(testRequest.id)).called(1);
    });

    test('should remove duplicate requests only once', () async {
      // arrange
      final requestsWithDuplicates = [testRequest, duplicateRequest];
      when(() => mockDataSource.fetchPendingRequests())
          .thenAnswer((_) async => requestsWithDuplicates);
      when(() => mockDataSource.removeRequest(any()))
          .thenAnswer((_) async {});
      // act
      await repository.processQueue();
      // assert
      verify(() => mockDataSource.fetchPendingRequests()).called(1);
      // since testRequest and duplicateRequest have the same id, removeRequest should be called only once.
      verify(() => mockDataSource.removeRequest(testRequest.id)).called(1);
    });
  });
}
