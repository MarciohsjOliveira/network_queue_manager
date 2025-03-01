import 'package:network_queue_manager/src/domain/erros/erros.dart';
import 'package:test/test.dart';

void main() {
  group('DomainError', () {
    test('deve criar uma instância de DomainError com a mensagem correta', () {
      const errorMessage = 'Erro de domínio';
      final error = DomainError(errorMessage);

      expect(error.message, errorMessage);
      expect(error.toString(), 'DomainError: $errorMessage');
    });

    test('deve criar uma instância de InvalidRequestError com a mensagem correta', () {
      const errorMessage = 'Requisição inválida';
      final error = InvalidRequestError(errorMessage);

      expect(error.message, errorMessage);
      expect(error.toString(), 'DomainError: $errorMessage');
    });

    test('deve criar uma instância de AddRequestError com a mensagem correta', () {
      const errorMessage = 'Erro ao adicionar requisição';
      final error = AddRequestError(errorMessage);

      expect(error.message, errorMessage);
      expect(error.toString(), 'DomainError: $errorMessage');
    });
  });
}