/// Enumeração que representa os métodos HTTP.
enum HttpMethod {
  /// Método HTTP GET.
  GET,

  /// Método HTTP POST.
  POST,

  /// Método HTTP PUT.
  PUT,

  /// Método HTTP DELETE.
  DELETE,
}

extension HttpMethodExtension on HttpMethod {
  /// Retorna a string correspondente ao método HTTP.
  String get name {
    switch (this) {
      case HttpMethod.GET:
        return 'GET';
      case HttpMethod.POST:
        return 'POST';
      case HttpMethod.PUT:
        return 'PUT';
      case HttpMethod.DELETE:
        return 'DELETE';
    }
  }
}
