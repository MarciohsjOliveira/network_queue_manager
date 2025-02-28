import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class NetworkQueueRepositoryImpl implements NetworkQueueRepository {
  final QueueLocalDataSource _dataSource;

  NetworkQueueRepositoryImpl(this._dataSource);

  @override
  Future<void> addRequest(NetworkRequest request) async {
    await _dataSource.saveRequest(request);
  }

  List<NetworkRequest>? _cachedRequests;

  @override
  Future<void> processQueue() async {
    _cachedRequests = await _dataSource.fetchPendingRequests();
    final processedRequestIds = <String>{};
    for (var req in _cachedRequests!) {
      if (!processedRequestIds.contains(req.id)) {
        processedRequestIds.add(req.id);
        await _dataSource.removeRequest(req.id);
      }
    }
  }

  @override
  Future<List<NetworkRequest>> getPendingRequests() async {
    return _cachedRequests ?? await _dataSource.fetchPendingRequests();
  }
}
