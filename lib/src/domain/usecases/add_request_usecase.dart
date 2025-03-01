import '../entities/entities.dart';
import '../erros/erros.dart';
import '../repository/repository.dart';

/// Interface para o caso de uso de adicionar uma requisição de rede.
abstract class AddRequestUseCase {
  /// Adiciona uma requisição de rede.
  ///
  /// Lança [DomainError] se a requisição for inválida ou se ocorrer um erro ao adicionar a requisição.
  Future<void> call(NetworkRequest request);
}

/// Implementação concreta do caso de uso de adicionar uma requisição de rede.
class AddRequestUseCaseImpl implements AddRequestUseCase {
  final NetworkQueueRepository _repository;

  /// Construtor que aceita um repositório de fila de rede.
  const AddRequestUseCaseImpl({required NetworkQueueRepository repository})
    : _repository = repository;

  @override
  Future<void> call(NetworkRequest request) async {
    // Validação adicional da requisição
    if (request.id.isEmpty || request.url.isEmpty) {
      throw DomainError('ID ou URL da requisição não podem estar vazios');
    }

    try {
      await _repository.addRequest(request);
    } catch (e) {
      // Tratamento de erros ao adicionar a requisição
      throw DomainError('Erro ao adicionar a requisição: ${e.toString()}');
    }
  }
}
