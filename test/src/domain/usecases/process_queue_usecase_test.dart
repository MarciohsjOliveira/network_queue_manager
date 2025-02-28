
import 'package:mocktail/mocktail.dart';
import 'package:network_queue_manager/src/domain/repository/repository.dart';
import 'package:network_queue_manager/src/domain/usecases/process_queue_usecase.dart';
import 'package:test/test.dart';

class MockNetworkQueueRepository extends Mock
    implements NetworkQueueRepository {}

void main() {
  late ProcessQueueUseCaseImpl useCase;
  late MockNetworkQueueRepository mockRepository;

  setUp(() {
    mockRepository = MockNetworkQueueRepository();
    useCase = ProcessQueueUseCaseImpl(repository: mockRepository);
  });

  test('should call processQueue on the repository', () async {
    // arrange
    when(() => mockRepository.processQueue()).thenAnswer((_) async => Future.value(null));

    // act
    await useCase.call();

    // assert
    verify(() => mockRepository.processQueue()).called(1);
  });
}
