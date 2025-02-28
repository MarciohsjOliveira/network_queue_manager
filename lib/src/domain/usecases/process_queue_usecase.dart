import 'package:network_queue_manager/src/domain/repository/repository.dart'
    show NetworkQueueRepository;

abstract class ProcessQueueUseCase {
  Future<void> call();
}

class ProcessQueueUseCaseImpl implements ProcessQueueUseCase {
  final NetworkQueueRepository _repository;

  ProcessQueueUseCaseImpl({required NetworkQueueRepository repository})
    : _repository = repository;

  @override
  Future<void> call() => _repository.processQueue();
}
