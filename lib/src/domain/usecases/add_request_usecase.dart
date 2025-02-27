import '../entities/entities.dart';
import '../repository/repository.dart';

abstract class AddRequestUseCase {
  Future<void> call(NetworkRequest request);
}

class AddRequestUseCaseImpl implements AddRequestUseCase {
  final NetworkQueueRepository _repository;

  const AddRequestUseCaseImpl({required NetworkQueueRepository repository})
    : _repository = repository;
    
  @override
  Future<void> call(NetworkRequest request) => _repository.addRequest(request);
}
