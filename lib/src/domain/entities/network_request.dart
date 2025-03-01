import '../enums/enums.dart';

/// Representa uma requisição de rede.
class NetworkRequest {
  final String id;
  final HttpMethod method;
  final String url;
  final Map<String, dynamic>? body;

  /// Construtor para criar uma instância de [NetworkRequest].
  ///
  /// Lança [ArgumentError] se a URL fornecida for inválida.
  NetworkRequest({
    required this.id,
    required this.method,
    required this.url,
    this.body,
  }) {
    if (!_isValidUrl(url)) {
      throw ArgumentError('A URL fornecida é inválida: $url');
    }
  }

  /// Verifica se a URL fornecida é válida.
  ///
  /// Retorna `true` se a URL for válida, caso contrário, `false`.
  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }
}