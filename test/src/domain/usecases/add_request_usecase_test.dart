import 'package:mocktail/mocktail.dart';
import 'package:network_queue_manager/src/domain/entities/entities.dart';
import 'package:network_queue_manager/src/domain/enums/enums.dart';
import 'package:network_queue_manager/src/domain/repository/repository.dart';
import 'package:network_queue_manager/src/domain/usecases/usecases.dart';
import 'package:test/test.dart';

class MockNetworkQueueRepository extends Mock implements NetworkQueueRepository {}

void main() {
  late AddRequestUseCase addRequestUseCase;
  late MockNetworkQueueRepository mockRepository;

  setUp(() {
    mockRepository = MockNetworkQueueRepository();
    addRequestUseCase = AddRequestUseCaseImpl(repository: mockRepository);
  });

  test('Deve chamar addRequest do repositório ao executar o use case', () async {
    final request = NetworkRequest(id: '1', method: HttpMethod.POST, url: 'https://api.example.com');

    when(() => mockRepository.addRequest(request)).thenAnswer((_) async {});

    await addRequestUseCase.call(request);

    verify(() => mockRepository.addRequest(request)).called(1);
  });
}


