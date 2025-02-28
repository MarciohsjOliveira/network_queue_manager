import '../../domain/entities/entities.dart';

abstract class QueueLocalDataSource {
  Future<void> saveRequest(NetworkRequest request);
  Future<List<NetworkRequest>> fetchPendingRequests();
  Future<void> removeRequest(String id);
}
