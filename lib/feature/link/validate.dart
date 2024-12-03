class UrlValidator {
  static bool isValid(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.isScheme('HTTP') || uri.isScheme('HTTPS')) &&
        uri.toString().length > 8 &&
        uri.authority.isNotEmpty &&
        uri.origin.isNotEmpty;
  }
}
