import '../entities/entities.dart';

abstract class NetworkQueueRepository {
  Future<void> addRequest(NetworkRequest request);
  Future<List<NetworkRequest>> getPendingRequests();
  Future<void> processQueue();
}