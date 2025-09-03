// ignore: depend_on_referenced_packages, library_prefixes
import 'package:html/parser.dart' as htmlParser;

class HtmlToPlainText {
  static String returnPlainText(String html) {
    final document = htmlParser.parse(html);
    return document.body?.text ?? '';
  }
}
