/// Classe base para erros específicos da camada de domínio.
class DomainError implements Exception {
  final String message;

  DomainError(this.message);

  @override
  String toString() => 'DomainError: $message';
}

/// Erro específico para requisições inválidas.
class InvalidRequestError extends DomainError {
  InvalidRequestError(String message) : super(message);
}

/// Erro específico para falhas ao adicionar uma requisição.
class AddRequestError extends DomainError {
  AddRequestError(String message) : super(message);
}