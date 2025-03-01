import 'package:network_queue_manager/src/domain/enums/enums.dart';
import 'package:test/test.dart';

void main() {
  group('HttpMethod', () {
    test('deve conter os métodos corretos', () {
      expect(HttpMethod.values.length, 4);
      expect(
        HttpMethod.values,
        containsAll([
          HttpMethod.GET,
          HttpMethod.POST,
          HttpMethod.PUT,
          HttpMethod.DELETE,
        ]),
      );
    });

    test('deve retornar a string correta para cada método', () {
      expect(HttpMethod.GET.name, 'GET');
      expect(HttpMethod.POST.name, 'POST');
      expect(HttpMethod.PUT.name, 'PUT');
      expect(HttpMethod.DELETE.name, 'DELETE');
    });
  });
}
