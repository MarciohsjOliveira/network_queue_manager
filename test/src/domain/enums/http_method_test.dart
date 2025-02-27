import 'package:network_queue_manager/src/domain/enums/enums.dart';
import 'package:test/test.dart';

void main() {
  group('HttpMethod', () {
    test('deve conter os métodos corretos', () {
      expect(HttpMethod.values.length, 4);
      expect(HttpMethod.values, contains(HttpMethod.GET));
      expect(HttpMethod.values, contains(HttpMethod.POST));
      expect(HttpMethod.values, contains(HttpMethod.PUT));
      expect(HttpMethod.values, contains(HttpMethod.DELETE));
    });
  });
}