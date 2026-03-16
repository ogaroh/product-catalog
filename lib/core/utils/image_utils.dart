import 'dart:developer' as dev;

/// Utilities for image URL validation and placeholder fallback.
abstract final class ImageUtils {
  /// Returns [url] if it is a valid HTTP/HTTPS URL, otherwise null.
  static String? validateUrl(String? url, {String? fieldName}) {
    if (url == null || url.isEmpty) {
      if (fieldName != null) {
        dev.log(
          'Missing image URL for field "$fieldName"',
          name: 'ImageUtils',
          level: 800, // WARNING
        );
      }
      return null;
    }

    final uri = Uri.tryParse(url);
    if (uri == null || (!uri.hasScheme) || uri.scheme != 'https' && uri.scheme != 'http') {
      dev.log(
        'Invalid image URL "$url" for field "$fieldName"',
        name: 'ImageUtils',
        level: 800,
      );
      return null;
    }

    return url;
  }

  /// Filters a list down to valid HTTP/HTTPS URLs.
  static List<String> filterUrls(List<String>? urls, {String? fieldName}) {
    if (urls == null || urls.isEmpty) return [];
    return urls
        .map((u) => validateUrl(u, fieldName: fieldName))
        .whereType<String>()
        .toList();
  }
}
