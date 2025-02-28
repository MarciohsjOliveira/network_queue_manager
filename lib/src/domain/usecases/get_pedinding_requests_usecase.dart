import '../entities/entities.dart';
import '../erros/erros.dart';
import '../repository/repository.dart';

/// Interface para o caso de uso de obter requisições de rede pendentes.
abstract class GetPendingRequestsUseCase {
  /// Obtém uma lista de requisições de rede pendentes.
  ///
  /// Lança [DomainError] se ocorrer um erro ao obter as requisições.
  Future<List<NetworkRequest>> call();
}

/// Implementação concreta do caso de uso de obter requisições de rede pendentes.
class GetPendingRequestsUseCaseImpl implements GetPendingRequestsUseCase {
  final NetworkQueueRepository _repository;

  /// Construtor que aceita um repositório de fila de rede.
  const GetPendingRequestsUseCaseImpl({
    required NetworkQueueRepository repository,
  }) : _repository = repository;

  @override
  Future<List<NetworkRequest>> call() async {
    try {
      return await _repository.getPendingRequests();
    } catch (e) {
      // Tratamento de erros ao obter as requisições pendentes
      throw DomainError(
        'Erro ao obter as requisições pendentes: ${e.toString()}',
      );
    }
  }
}
