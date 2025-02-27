import '../enums/enums.dart';

class NetworkRequest {
  final String id;
  final HttpMethod method;
  final String url;
  final Map<String, dynamic>? body;

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

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }
}