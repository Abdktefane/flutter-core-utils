import 'dart:convert';

extension UriExtension on Uri {
  static String toUrl(String text) => Uri.dataFromString(
        text,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString();
}
