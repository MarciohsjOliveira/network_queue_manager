# Network Queue Manager

A Flutter package for managing offline network requests with automatic retry when the connection is restored. This package stores requests locally using Hive and processes them once connectivity is available.

## Features
- Queue network requests while offline
- Store requests using Hive
- Automatically retry requests when back online
- Supports GET, POST, PUT, DELETE methods
- Unit tested and ready for production

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  network_queue_manager: latest_version
```

Then, run:

```sh
dart pub get
```

## Usage

### Initialization

Before using the package, initialize Hive:

```dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:network_queue_manager/network_queue_manager.dart';

void main() async {
  await Hive.initFlutter();
  final dataSource = QueueHiveDataSource();
  await dataSource.init();
  final queue = NetworkQueueManager(dataSource);
}
```

### Adding Requests to the Queue

```dart
await queue.addRequest(NetworkRequest(
  id: '1',
  method: HttpMethod.post,
  url: 'https://api.example.com/data',
));
```

### Retrieving Pending Requests

```dart
final pendingRequests = await queue.getPendingRequests();
print('Pending requests: ${pendingRequests.length}');
```

### Processing the Queue

```dart
await queue.processQueue();
```

## Example

For a complete example, check the `example/` directory.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

