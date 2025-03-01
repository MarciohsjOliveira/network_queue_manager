
import 'package:mocktail/mocktail.dart';
import 'package:network_queue_manager/src/domain/erros/domain_error.dart';
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

  test('should throw DomainError when repository throws an exception', () async {
  // arrange
  final exception = Exception('Repository error');
  when(() => mockRepository.processQueue()).thenThrow(exception);

  // act
  final call = useCase.call();

  // assert
  expect(() => call, throwsA(isA<DomainError>()));
  verify(() => mockRepository.processQueue()).called(1);
});
}
