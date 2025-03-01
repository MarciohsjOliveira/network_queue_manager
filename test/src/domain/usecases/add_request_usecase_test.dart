import 'package:mocktail/mocktail.dart';
import 'package:network_queue_manager/src/domain/entities/entities.dart';
import 'package:network_queue_manager/src/domain/enums/enums.dart';
import 'package:network_queue_manager/src/domain/erros/erros.dart';
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

  test('Deve lançar DomainError se o id estiver vazio', () async {
    final request = NetworkRequest(id: '', method: HttpMethod.POST, url: 'https://api.example.com');

    expect(
      () async => await addRequestUseCase.call(request),
      throwsA(predicate((e) =>
          e is DomainError && e.message == 'ID ou URL da requisição não podem estar vazios')),
    );
  });



  test('Deve lançar DomainError se ocorrer erro ao adicionar a requisição', () async {
    final request = NetworkRequest(id: '1', method: HttpMethod.POST, url: 'https://api.example.com');
    final repositoryException = Exception('Erro no repositório');

    when(() => mockRepository.addRequest(request)).thenThrow(repositoryException);

    expect(
      () async => await addRequestUseCase.call(request),
      throwsA(predicate((e) =>
          e is DomainError &&
          e.message == 'Erro ao adicionar a requisição: ${repositoryException.toString()}')),
    );
  });
}
