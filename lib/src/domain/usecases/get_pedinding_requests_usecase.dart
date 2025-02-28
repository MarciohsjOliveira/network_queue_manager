import '../entities/entities.dart';
import '../repository/repository.dart';

abstract class GetPendingRequestsUseCase {
  Future<List<NetworkRequest>> call();
}

class GetPendingRequestsUseCaseImpl implements GetPendingRequestsUseCase {
  final NetworkQueueRepository _repository;

  const GetPendingRequestsUseCaseImpl({
    required NetworkQueueRepository repository,
  }) : _repository = repository;

  @override
  Future<List<NetworkRequest>> call() => _repository.getPendingRequests();
}
