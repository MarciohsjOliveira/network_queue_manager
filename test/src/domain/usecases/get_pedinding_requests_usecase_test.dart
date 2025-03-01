

import 'package:mocktail/mocktail.dart';
import 'package:network_queue_manager/src/domain/entities/entities.dart';
import 'package:network_queue_manager/src/domain/enums/enums.dart';
import 'package:network_queue_manager/src/domain/repository/repository.dart';
import 'package:network_queue_manager/src/domain/usecases/get_pedinding_requests_usecase.dart';
import 'package:test/test.dart';

class MockNetworkQueueRepository extends Mock implements NetworkQueueRepository {}

void main() {
  late GetPendingRequestsUseCaseImpl useCase;
  late MockNetworkQueueRepository mockRepository;

  setUp(() {
    mockRepository = MockNetworkQueueRepository();
    useCase = GetPendingRequestsUseCaseImpl(repository: mockRepository);
  });

  test('should return a list of pending network requests', () async {
    // Arrange
    final pendingRequests = [
      NetworkRequest(id: '1', method: HttpMethod.GET, url: 'https://example.com/1'),
      NetworkRequest(id: '2', method: HttpMethod.POST, url: 'https://example.com/2')
    ];
    when(() => mockRepository.getPendingRequests()).thenAnswer((_) async => pendingRequests);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, pendingRequests);
    verify(() => mockRepository.getPendingRequests()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return an empty list when there are no pending requests', () async {
    // Arrange
    when(() => mockRepository.getPendingRequests()).thenAnswer((_) async => []);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, []);
    verify(() => mockRepository.getPendingRequests()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should throw an exception when repository throws an exception', () async {
    // Arrange
    when(() => mockRepository.getPendingRequests()).thenThrow(Exception('Error'));

    // Act
    final call = useCase.call;

    // Assert
    expect(() => call(), throwsA(isA<Exception>()));
    verify(() => mockRepository.getPendingRequests()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
