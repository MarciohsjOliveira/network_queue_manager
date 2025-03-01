import 'package:network_queue_manager/src/domain/repository/repository.dart';
import '../erros/erros.dart';

/// Interface para o caso de uso de processar a fila de requisições de rede.
abstract class ProcessQueueUseCase {
  /// Processa a fila de requisições de rede.
  ///
  /// Lança [DomainError] se ocorrer um erro ao processar a fila.
  Future<void> call();
}

/// Implementação concreta do caso de uso de processar a fila de requisições de rede.
class ProcessQueueUseCaseImpl implements ProcessQueueUseCase {
  final NetworkQueueRepository _repository;

  /// Construtor que aceita um repositório de fila de rede.
  const ProcessQueueUseCaseImpl({required NetworkQueueRepository repository})
    : _repository = repository;

  @override
  Future<void> call() async {
    try {
      await _repository.processQueue();
    } catch (e) {
      // Tratamento de erros ao processar a fila
      throw DomainError('Erro ao processar a fila de requisições: ${e.toString()}');

    }
  }
}