import 'package:test/test.dart';
import 'package:network_queue_manager/src/domain/entities/entities.dart';
import 'package:network_queue_manager/src/domain/enums/enums.dart';
void main() {
  group('NetworkRequest', () {
    test('deve criar uma instância válida', () {
      final request = NetworkRequest(
        id: '1',
        method: HttpMethod.POST,
        url: 'https://api.example.com',
      );
      expect(request.id, '1');
      expect(request.method, HttpMethod.POST);
      expect(request.url, 'https://api.example.com');
    });

    test('deve lançar erro se a URL for inválida', () {
      expect(
        () => NetworkRequest(
          id: '1',
          method: HttpMethod.GET,
          url: 'invalid_url',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
